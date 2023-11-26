//
//  ImageLoadingView.swift
//  IntermediateBootcamp
//
//  Created by Denis DRAGAN on 21.11.2023.
//

import SwiftUI

struct ImageLoadingView: View {
    @StateObject var loader: ImageLoadingViewModel
    
    init(url: String, key: String) {
        _loader = StateObject(wrappedValue: ImageLoadingViewModel(url: url, key: key))
    }
    
    var body: some View {
        ZStack {
            if loader.isLoading {
                ProgressView()
            } else if let image = loader.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
            }
        }
    }
}

#Preview {
    ImageLoadingView(url: "https://via.placeholder.com/600/92c952", key: "2")
}
