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
                    self.saveImageToCoreData(imageData, albumID: self.selectedAlbumID)
                }
            }
        }
//        AlbumsVC.fetchFromCoreData()
    }
    
    func fetchImages() {
        photoArray.removeAll(keepingCapacity: false)
        photoArray.append(PhotoModel(id: UUID(), imageData: (UIImage(named: "addingbtn")?.pngData())!, selected_album_id: UUID()))
        CoreDataManager.fetchImages(with: selectedAlbumID) { data in
            if let id = data.value(forKey: "id") as? UUID, let imageData = data.value(forKey: "imageData") as? Data, let album_id = data.value(forKey: "selected_album_id") as? UUID {
                photoArray.append(PhotoModel(id: id, imageData: imageData, selected_album_id: album_id))
            }
        }
    }
    
    func saveImageToCoreData(_ imageData: Data, albumID: UUID) {
        let id = UUID()
        if let albumIndex = albumArray.firstIndex(where: { $0.id == albumID }) {
            CoreDataManager.saveData(container: "Vault", entity: "Photo", attributeDict: [
                "imageData": imageData,
                "selected_album_id": albumID,
                "id": id
            ])
            let photo = PhotoModel(id: id, imageData: imageData, selected_album_id: albumID)
            albumArray[albumIndex].images?.append(photo)
            collectionView.reloadData()
        }
    }
}
