//
//  PhotoModel.swift
//  IntermediateBootcamp
//
//  Created by Denis DRAGAN on 21.11.2023.
//

import Foundation

struct PhotoModel: Identifiable, Codable {
    let albumId: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
}
