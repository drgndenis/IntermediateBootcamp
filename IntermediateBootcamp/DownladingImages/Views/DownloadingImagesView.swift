//
//  DownloadingImagesView.swift
//  IntermediateBootcamp
//
//  Created by Denis DRAGAN on 21.11.2023.
//

import SwiftUI

// Topics
/*
 Codable
 Background Threads
 Weak Self
 Combine
 Publisher and Subscriber
 File Manager
 NSCache
 */

struct DownloadingImagesView: View {
    @StateObject var vm = DownloadingImagesViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(vm.dataArray) { model in
                    DownloadingImagesRow(model: model)
                }
            }
            .navigationTitle("Downloading Images!")
        }
    }
}

#Preview {
    DownloadingImagesView()
}


