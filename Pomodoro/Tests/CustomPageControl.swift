//
//  CustomPageControl.swift
//  Pomodoro
//
//  Created by Damien Chailloleau on 07/06/2024.
//

import SwiftUI

struct CustomPageControl: View {
    var totalIndex: Int
    var selectedIndex: Int
    
    @Namespace private var animation
    
    var body: some View {
        HStack {
            ForEach(0 ..< totalIndex, id: \.self) { index in // 1
                if selectedIndex == index {
                    Rectangle()
                        .fill(.gray.opacity(0.3))
                        .frame(height: 5)
                        .clipShape(RoundedRectangle(cornerRadius: 3))
                        .overlay {
                            Rectangle() // 2
                                .fill(.purple)
                                .frame(height: 5)
                                .clipShape(
                                    RoundedRectangle(cornerRadius: 3)
                                )
                                .matchedGeometryEffect(id: "IndicatorAnimationId", in: animation) // 3
                        }
                } else {
                    Rectangle()
                        .fill(.gray.opacity(0.3))
                        .frame(height: 5)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 3)
                        )
                }
            }
        }
        .animation(.spring(), value: UUID()) // 4
    }
}

#Preview {
    CustomPageControl(totalIndex: 2, selectedIndex: .zero)
}
