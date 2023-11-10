//
//  NotesTableView.swift
//  Vault
//
//  Created by Mehmet Kaan on 4.11.2023.
//

import UIKit
import NeonSDK

class NotesTableView: NeonTableView<NoteModel, NotesCell> {
    
    convenience init() {
        self.init(objects: noteArray, heightForRows: 113, style: .plain)
        self.didSelect = didSelect
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredNoteArray.isEmpty ? noteArray.count : filteredNoteArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = NotesCell()
        if filteredNoteArray.isEmpty {
            cell.configure(with: noteArray[indexPath.row])
        } else {
            cell.configure(with: filteredNoteArray[indexPath.row])
        }
        return cell
    }
    
}
