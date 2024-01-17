//
//  LearnViewBuilder.swift
//  IntermediateBootcamp
//
//  Created by Denis DRAGAN on 17.01.2024.
//

import SwiftUI

struct HeaderViewRegular: View {
    let title: String
    let description: String?
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.largeTitle)
                .fontWeight(.semibold)
            if let description = description {
                Text(description)
                    .font(.callout)
            }
            RoundedRectangle(cornerRadius: 5)
                .frame(height: 2)
        }
        //.frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
}

struct HeaderViewGenerics<Content: View>: View {
    let title: String
    let content: Content
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.largeTitle)
                .fontWeight(.semibold)
            content
            
            RoundedRectangle(cornerRadius: 5)
                .frame(height: 2)
        }
        //.frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
}

struct LocalViewBuilder: View {
    enum ViewType {
        case one, two, three
    }
    let type: ViewType
    
    var body: some View {
        VStack {
            headerSection
        }
    }
    
    @ViewBuilder private var headerSection: some View {
        switch type {
        case .one:
            viewOne
        case .two:
            viewTwo
        case .three:
            viewThree
        }
    }
    
    
    // VIEWS
    private var viewOne: some View {
        Text("ONE")
    }
    
    private var viewTwo: some View {
        VStack {
            Text("TWOOOO")
            Image(systemName: "heart.fill")
        }
    }
    
    private var viewThree: some View {
        Image(systemName: "heart.fill")
    }
}

struct LearnViewBuilder: View {
    var body: some View {
        VStack {
            HeaderViewRegular(title: "Title", description: "hello")
            HeaderViewRegular(title: "Title2", description: nil)
            HeaderViewGenerics(title: "Generic Title") {
                Text("Generic description")
            }
            HeaderViewGenerics(title: "Generic Title2") {
                HStack {
                    Text("Bolt TIME")
                    Image(systemName: "bolt.fill")
                }
            }
            
            Spacer()
        }
    }
}

#Preview {
    LocalViewBuilder(type: .two)
}
