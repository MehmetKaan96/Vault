//
//  CoreDataManagerExtension.swift
//  Vault
//
//  Created by Mehmet Kaan on 3.11.2023.
//

import Foundation
import NeonSDK
import CoreData

extension CoreDataManager {
    public static func fetchAlbumsAndPhotos(container: String, completion: @escaping ([Album]?) -> Void) {
        let context = persistentContainer(container: container).viewContext
        
        let fetchRequest = NSFetchRequest<Album>(entityName: "Album")
        
        do {
            let albums = try context.fetch(fetchRequest)
            completion(albums)
        } catch {
            print("Error fetching albums: \(error)")
            completion(nil)
        }
    }
    
    public static func fetchPhotosInAlbum(container: String, album: Album, completion: @escaping ([Photo]?) -> Void) {
        if let photos = album.images?.array as? [Photo] {
            completion(photos)
        } else {
            print("Error fetching photos for the album")
            completion(nil)
        }
    }
}
