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
        CoreDataManager.fetchDatas(container: "Vault", entity: "Note") { [self] data in
            if let text = data.value(forKey: "title") as? String, let desc = data.value(forKey: "desc") as? String {
                noteArray.append(NoteModel(title: text, description: desc))
            }
            notesTableView.objects = noteArray
        }
    }
}

extension NotesVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        filteredNoteArray = noteArray.filter({ note in
            return note.title.lowercased().contains(searchText.lowercased())
        })
        notesTableView.objects = filteredNoteArray
        if searchText.isEmpty {
            filteredNoteArray.removeAll()
            notesTableView.objects = noteArray
        }
        notesTableView.reloadData()
    }
}
