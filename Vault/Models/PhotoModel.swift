//
//  PhotoModel.swift
//  Vault
//
//  Created by Mehmet Kaan on 2.11.2023.
//

import Foundation
import UIKit

struct PhotoModel {
    let id: UUID
    let imageData: Data
    let selected_album_id: UUID
}

var photoArray: [PhotoModel] = []
