//
//  AlbumPhotosExtension.swift
//  Vault
//
//  Created by Mehmet Kaan on 3.11.2023.
//

import Foundation
import PhotosUI
import NeonSDK
import CoreData

extension AlbumPhotosVC: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true, completion: nil)
        
        guard let result = results.first else {
            return
        }
        
        result.itemProvider.loadFileRepresentation(forTypeIdentifier: UTType.image.identifier) { url, error in
            if let error = error {
                print("Error loading image: \(error)")
            } else if let url = url {
                if let imageData = try? Data(contentsOf: url) {
                    AlbumPhotosVC.saveImageToCoreData(imageData, albumName: self.selectedAlbum.name)
                }
            }
        }
        AlbumsVC.fetchFromCoreData()
    }
    
    static func saveImageToCoreData(_ imageData: Data, albumName: String) {
        if let albumIndex = albumArray.firstIndex(where: { $0.name == albumName }) {
            let album = albumArray[albumIndex]
            CoreDataManager.saveData(container: "Vault", entity: "Photo", attributeDict: [
                "imageData": imageData
            ])
            let photo = PhotoModel(imageData: imageData)
            albumArray[albumIndex].images.append(photo)
        }
    }
    
}
