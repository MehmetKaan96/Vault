//
//  NotesVCExtension.swift
//  Vault
//
//  Created by Mehmet Kaan on 4.11.2023.
//

import Foundation
import UIKit
import NeonSDK

extension NotesVC: UITextFieldDelegate {
    func fetchFromCoreData() {
        noteArray.removeAll(keepingCapacity: false)
        CoreDataManager.fetchDatas(container: "Vault", entity: "Note") { data in
            if let text = data.value(forKey: "title") as? String {
                noteArray.append(NoteModel(title: text, description: text))
            }
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
}
