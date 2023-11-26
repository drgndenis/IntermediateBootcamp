//
//  RotationGesture.swift
//  IntermediateBootcamp
//
//  Created by Denis DRAGAN on 8.11.2023.
//

import SwiftUI

struct LearnRotationGesture: View {
    @State private var angle: Angle = Angle(degrees: 0)
    
    var body: some View {
        Text("Hello, World!")
            .font(.largeTitle)
            .fontWeight(.semibold)
            .foregroundStyle(.white)
            .padding(50)
            .background(.blue)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .rotationEffect(angle)
            .gesture(RotateGesture()
                .onChanged{ value in
                    angle = value.rotation
                }
                .onEnded { _ in
                    withAnimation(.spring) {
                        angle = Angle(degrees: 0)
                    }
                }
            )
    }
}

#Preview {
    LearnRotationGesture()
}
