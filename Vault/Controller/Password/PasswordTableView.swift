//
//  PasswordTableView.swift
//  Vault
//
//  Created by Mehmet Kaan on 4.11.2023.
//

import UIKit
import NeonSDK

class PasswordTableView: NeonTableView<PasswordModel, PasswordCell> {


    convenience init() {
        self.init(objects: passwordArray, heightForRows: 60, style: .plain)
        self.didSelect = didSelect
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredPasswordArray.isEmpty ? passwordArray.count : filteredPasswordArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = PasswordCell()
        if filteredPasswordArray.isEmpty {
            cell.configure(with: passwordArray[indexPath.row])
        } else {
            cell.configure(with: filteredPasswordArray[indexPath.row])
        }
        return cell
    }
}
