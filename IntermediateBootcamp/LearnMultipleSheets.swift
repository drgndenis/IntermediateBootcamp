//
//  LearnMultipleSheets.swift
//  IntermediateBootcamp
//
//  Created by Denis DRAGAN on 11.11.2023.
//

import SwiftUI

struct MultipleSheetsModel: Identifiable {
    let id = UUID().uuidString
    let title: String
}

struct LearnMultipleSheets: View {
    @State private var selectedModel: MultipleSheetsModel?
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(1..<50) { item in
                    Button("Button \(item)") {
                        selectedModel = MultipleSheetsModel(title: "\(item)")
                    }
                }
                .sheet(item: $selectedModel) { model in
                    NextView(selectedModel: model)
                }
            }
        }
        .scrollIndicators(.hidden)
    }
}

struct NextView: View {
    let selectedModel: MultipleSheetsModel
    
    var body: some View {
        Text(selectedModel.title)
            .font(.largeTitle)
    }
}

#Preview {
    LearnMultipleSheets()
}
