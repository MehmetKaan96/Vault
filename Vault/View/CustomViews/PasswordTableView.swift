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
        self.init(objects: passwordArray, heightForRows: 50, style: .plain)
        self.didSelect = didSelect
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = PasswordCell()
        
        cell.configure(with: passwordArray[indexPath.row])
        return cell
    }
    
}
