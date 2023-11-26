//
//  CustomTextButton.swift
//  IntermediateBootcamp
//
//  Created by Denis DRAGAN on 20.11.2023.
//

import SwiftUI

struct CustomButtonText: View {
    let textName: String
    let backgroundColor: Color
    
    var body: some View {
        Text(textName)
            .foregroundStyle(.white)
            .font(.headline)
            .bold()
            .padding()
            .padding(.horizontal)
            .background(backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}


#Preview {
    CustomButtonText(textName: "Testing", backgroundColor: .blue)
}
