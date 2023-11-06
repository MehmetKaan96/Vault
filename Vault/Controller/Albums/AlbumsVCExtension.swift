//
//  AlbumsVCExtension.swift
//  Vault
//
//  Created by Mehmet Kaan on 2.11.2023.
//

import Foundation
import UIKit
import NeonSDK

extension AlbumsVC {
    func fetchFromCoreData() {
        albumArray.removeAll(keepingCapacity: false)
        photoArray.removeAll(keepingCapacity: false)
        photoArray.append(PhotoModel(id: UUID(), imageData: (UIImage(named: "addingbtn")?.pngData())!, selected_album_id: UUID()))
        CoreDataManager.fetchDatas(container: "Vault", entity: "Album") { data in
            if let name = data.value(forKey: "name") as? String, let id = data.value(forKey: "id") as? UUID{
                var photos: [PhotoModel] = []
                CoreDataManager.fetchImages(with: id) { data in
                    if let images = data.value(forKey: "imageData") as? Data, let id = data.value(forKey: "id") as? UUID, let album_id = data.value(forKey: "selected_album_id") as? UUID {
                        photos.append(PhotoModel(id: id, imageData: images, selected_album_id: album_id))
                    }
                }
                albumArray.append(AlbumModel(id: id, name: name, images: photos))
            }
        }
    }
}
