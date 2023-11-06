//
//  AlbumModel.swift
//  Vault
//
//  Created by Mehmet Kaan on 2.11.2023.
//

import Foundation

struct AlbumModel {
    var id: UUID
    let name: String
    var images: [PhotoModel]? = nil
}

var albumArray: [AlbumModel] = []
