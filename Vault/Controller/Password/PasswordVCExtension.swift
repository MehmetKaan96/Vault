//
//  PasswordVCExtension.swift
//  Vault
//
//  Created by Mehmet Kaan on 4.11.2023.
//

import Foundation
import UIKit
import NeonSDK

extension PasswordVC: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let accountText = self.accountTextField.text {
            if accountText.lowercased().contains("apple") {
                passwordImageView.image = UIImage(named: "img_apple")
            } else if accountText.lowercased().contains("asana") {
                passwordImageView.image = UIImage(named: "img_asana")
            } else if accountText.lowercased().contains("blackberry") {
                self.passwordImageView.image = UIImage(named: "img_bbm")
            } else if accountText.lowercased().contains("behance") {
                self.passwordImageView.image = UIImage(named: "img_behance")
            } else if accountText.lowercased().contains("binance") {
                self.passwordImageView.image = UIImage(named: "img_binance")
            } else {
                self.passwordImageView.image = UIImage(named: "")
            }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == searchBar {
            let searchText = (textField.text! as NSString).replacingCharacters(in: range, with: string)
            performSearch(withText: searchText)
        }
        return true
    }
    
    func performSearch(withText searchText: String) {
        if searchText == "" {
            fetchDataFromCoreData()
        } else {
            let filteredArray = passwordArray.filter {
                $0.name.lowercased().contains(searchText.lowercased())
            }
            passwordTableView.objects = filteredArray
        }
    }
}

extension PasswordVC {
    func fetchDataFromCoreData() {
        passwordArray.removeAll(keepingCapacity: false)
        CoreDataManager.fetchDatas(container: "Vault", entity: "Password") { data in
            if let account_name = data.value(forKey: "account_name") as? String, let imageData = data.value(forKey: "image") as? Data, let login_account = data.value(forKey: "login_account") as? String, let password = data.value(forKey: "password") as? String, let website = data.value(forKey: "website") as? String, let id = data.value(forKey: "id") as? UUID{
                passwordArray.append(PasswordModel(id: id, name: account_name, account: login_account, password: password, website: website, image: imageData))
            }
            self.passwordTableView.objects = passwordArray
        }
        
    }
}

extension PasswordVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredPasswordArray = passwordArray.filter({ password in
            return password.name.lowercased().contains(searchText.lowercased())
        })
        passwordTableView.objects = filteredPasswordArray
        if searchText.isEmpty {
            filteredPasswordArray.removeAll()
            passwordTableView.objects = passwordArray
        }
        passwordTableView.reloadData()
    }
}
