//
//  LearnScrollViewReader.swift
//  IntermediateBootcamp
//
//  Created by Denis DRAGAN on 9.11.2023.
//

import SwiftUI

struct LearnScrollViewReader: View {
    @State private var scrollToIndex: Int = 0
    @State private var textField = ""
    
    var body: some View {
        ScrollView {
            TextField("Enter a number", text: $textField)
                .padding(.horizontal)
                .frame(height: 55)
                .border(.black)
                .padding(.horizontal)
                .keyboardType(.numberPad)
            
            Button(action: {
                withAnimation(.interactiveSpring) {
                    if let index = Int(textField) {
                        scrollToIndex = index
                    }
                }
            }, label: {
                Text("SCROLL NOW")
            })
            
            ScrollViewReader { proxy in
                ForEach(0..<50) { index in
                    Text("This is item #\(index)")
                        .font(.headline)
                        .frame(height: 200)
                        .frame(maxWidth: .infinity)
                        .background(.white)
                        .shadow(radius: 10)
                        .padding()
                        .id(index)
                }
                .onChange(of: scrollToIndex) {
                    withAnimation(.spring) {
                        proxy.scrollTo(scrollToIndex, anchor: .center)
                    }
                }
            }
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    LearnScrollViewReader()
}
