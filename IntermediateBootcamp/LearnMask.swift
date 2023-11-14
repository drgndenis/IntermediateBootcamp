//
//  LearnMask.swift
//  IntermediateBootcamp
//
//  Created by Denis DRAGAN on 11.11.2023.
//

import SwiftUI

struct LearnMask: View {
    @State private var rating: Int = 3
    var body: some View {
        ZStack {
            starsView
                .overlay {
                    geometryMask.mask(starsView)
                }
        }
    }
    
    private var starsView: some View {
        HStack {
            ForEach(1..<6) { index in
                Image(systemName: "star.fill")
                    .font(.largeTitle)
                    .foregroundStyle(.gray)
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            rating = index
                        }
                    }
            }
        }
    }
    
    private var geometryMask: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .foregroundStyle(.yellow)
                    .frame(width: CGFloat(rating) / 5 * geometry.size.width)
            }
        }
        .allowsHitTesting(false)
    }
}

#Preview {
    LearnMask()
}
