//
//  DownloadingImagesRow.swift
//  IntermediateBootcamp
//
//  Created by Denis DRAGAN on 21.11.2023.
//

import SwiftUI

struct DownloadingImagesRow: View {
    let model: PhotoModel
    
    var body: some View {
        HStack {
            ImageLoadingView(url: model.url, key: "\(model.id)")
                .frame(width: 75)
            VStack(alignment: .leading, spacing: 5) {
                Text(model.title)
                    .font(.headline)
                Text(model.url)
                    .foregroundStyle(.gray)
                    .italic()
            }
        }
    }
}

#Preview {
    DownloadingImagesRow(model: PhotoModel(albumId: 1, id: 1, title: "Testing for title", url: "https://via.placeholder.com/600/92c952", thumbnailUrl: "Thumbnailurl is here"))
}
