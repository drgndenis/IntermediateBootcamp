//
//  LearnTypealias.swift
//  IntermediateBootcamp
//
//  Created by Denis DRAGAN on 15.11.2023.
//

import SwiftUI

struct MoviesModel {
    let title: String
    let director: String
    let likeCount: Int
}

// Biz ozelligin digerini referans almasi
typealias TvModel = MoviesModel

struct LearnTypealias: View {
    var MovieItem: MoviesModel = MoviesModel(title: "Movie Title", director: "Joe", likeCount: 5)
    var tvItem: TvModel = TvModel(title: "TV Title", director: "McLeblanc", likeCount: 10)
    
    var body: some View {
        VStack(spacing: 20) {
            Text(MovieItem.title)
            Text(MovieItem.director)
            Text("\(MovieItem.likeCount)")
            Divider()
            Text(tvItem.title)
            Text(tvItem.director)
            Text("\(tvItem.likeCount)")
        }
        .font(.largeTitle)
    }
}

#Preview {
    LearnTypealias()
}
