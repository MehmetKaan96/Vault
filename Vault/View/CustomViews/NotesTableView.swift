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
        return noteArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = NotesCell()
        
        cell.configure(with: noteArray[indexPath.row])
        return cell
    }
    
}
