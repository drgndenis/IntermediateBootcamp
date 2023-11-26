//
//  MagnificationGesture.swift
//  IntermediateBootcamp
//
//  Created by Denis DRAGAN on 8.11.2023.
//

import SwiftUI

struct LearnMagnificationGesture: View {
    @State var magnifyBy = 0.0
    
    var body: some View {
        VStack(spacing: 15) {
            HStack {
                Circle()
                    .frame(width: 35)
                Text("@denisdrgn")
                Spacer()
                Image(systemName: "ellipsis")
            }
            .padding(.horizontal)
            
            Rectangle()
                .frame(height: 300)
                .scaleEffect(1 + magnifyBy)
                .gesture(
                    MagnifyGesture()
                        .onChanged({ value in
                            magnifyBy = value.magnification - 1
                        })
                        .onEnded({ value in
                            withAnimation(.easeIn) {
                                magnifyBy = 0
                            }
                        })
                    )
            
            HStack {
                Image(systemName: "heart.fill")
                Image(systemName: "text.bubble.fill")
                Spacer()
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    LearnMagnificationGesture()
}
