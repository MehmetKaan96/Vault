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
    public static func fetchImages(with id: UUID, dataFetched: @escaping(_ data : NSManagedObject) -> ()) {
        let context = persistentContainer(container: "Vault").viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Photo")
            fetchRequest.returnsObjectsAsFaults = false
            fetchRequest.predicate = NSPredicate(format: "selected_album_id == %@", id as CVarArg)
            do {
                let datas = try context.fetch(fetchRequest)
                for data in datas as! [NSManagedObject] {
                    dataFetched(data)
                }
            } catch {
                print("Error!")
            }
    }
}
