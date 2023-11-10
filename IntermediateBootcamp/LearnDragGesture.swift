//
//  DragGesture.swift
//  IntermediateBootcamp
//
//  Created by Denis DRAGAN on 9.11.2023.
//

import SwiftUI

struct LearnDragGesture: View {
    @State private var offset: CGSize = .zero
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .frame(width: 300, height: 500)
            .offset(offset)
            .gesture(
                DragGesture()
                    .onChanged{ value in
                        offset = value.translation
                    }
                    .onEnded{ _ in
                        withAnimation(.spring) {
                            offset = CGSize(width: 0, height: 0)
                        }
                    }
            )
    }
}

#Preview {
    LearnDragGesture()
}
