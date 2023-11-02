//
//  AlbumCollectionView.swift
//  Vault
//
//  Created by Mehmet Kaan on 2.11.2023.
//

import UIKit
import NeonSDK

class AlbumCollectionView: NeonCollectionView<AlbumModel, AlbumCell> {
    convenience init() {
        self.init(objects: albumArray, itemsPerRow: 3, leftPadding: 17, rightPadding: 17, horizontalItemSpacing: 10, verticalItemSpacing: 10, heightForItem: 162)
        self.didSelect = didSelect
    }
}
