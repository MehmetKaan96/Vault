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
    static func fetchFromCoreData() {
        albumArray.removeAll(keepingCapacity: false)
        photoArray.removeAll(keepingCapacity: false)
        CoreDataManager.fetchDatas(container: "Vault", entity: "Album") { albumData in
            if let albumName = albumData.value(forKey: "name") as? String {
                var photos: [PhotoModel] = []
                
                photos.append(PhotoModel(imageData: (UIImage(named: "addingbtn")?.pngData())!))
                
                CoreDataManager.fetchDatas(container: "Vault", entity: "Photo") { photoData in
                    if let imageData = photoData.value(forKey: "imageData") as? Data {
                        let photo = PhotoModel(imageData: imageData)
                        photos.append(photo)
                    }
                }
                photoArray.append(contentsOf: photos)
                albumArray.append(AlbumModel(name: albumName, images: photos))
            }
        }
    }
}
