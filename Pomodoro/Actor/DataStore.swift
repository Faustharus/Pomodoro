//
//  DataStore.swift
//  Pomodoro
//
//  Created by Damien Chailloleau on 10/06/2024.
//

import Foundation

protocol DataStore: Actor {
    // Using associatedtype allows Swift who is clever enough to understand the type that needs to be used when needed
    associatedtype D // Making the protocol generic
    
    func save(_ current: D)
    func load() -> D?
}

/* Uses a generic type to interact with every kind of struct as long as they have the Codable protocol where the model (struct) can be compared */
actor PlistDataStore<T: Codable>: DataStore where T: Equatable {
    
    typealias D = T
    
    private var saved: T?
    let filename: String
    
    init(filename: String) {
        self.filename = filename
    }
    
    private var dataURL: URL {
        // Uses the File System manager of the device to store the file(s) by appending an extension as the name of said file(s), in the documents Directory of the app (userDomainMask)
        FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathExtension("\(filename).plist")
    }
    
    func save(_ current: D) {
        // If the file already exists, the function exit's it self
        if let saved = self.saved, saved == current {
            return
        }
        
        do {
            let encoder = PropertyListEncoder() // Encode instances of data types into a property list (plist)
            encoder.outputFormat = .binary // Plist format used to encode the data
            let data = try encoder.encode(current) // Try to perform the encoding of the data, else catches the error
            try data.write(to: dataURL, options: [.atomic]) /* Write the data into the FileManager through the Atomic process */
            self.saved = current
            /* Which means write everything on a temporary file until everything's in and from there, rename the temporary to the target filename. i.e : The whole file is there or there's nothing */
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func load() -> D? {
        do {
            let data = try Data(contentsOf: dataURL) // Try to retrieve the data from the FileManager
            let decoder = PropertyListDecoder() // Decodes instances of data types from the property list (plist)
            let current = try decoder.decode(T.self, from: data) // Try to decode the data following the data type declared as self, else catches the error
            self.saved = current
            return current // Returns the data, if it is there
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
}
