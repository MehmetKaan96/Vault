//
//  PhotoCollectionView.swift
//  Vault
//
//  Created by Mehmet Kaan on 3.11.2023.
//

import UIKit
import NeonSDK

class PhotoCollectionView: NeonCollectionView<PhotoModel, PhotosCell> {
    
    convenience init() {
        self.init(objects: photoArray, itemsPerRow: 3, leftPadding: 17, rightPadding: 17, horizontalItemSpacing: 10, verticalItemSpacing: 10, heightForItem: 120)
        self.didSelect = didSelect
    }
}
