//
//  PasswordVC.swift
//  Vault
//
//  Created by Mehmet Kaan on 4.11.2023.
//

import UIKit
import NeonSDK

class PasswordVC: UIViewController {
    
    //Declarations
    var passwordTableView =  PasswordTableView()
    var searchBar = UISearchBar()
    let passwordImageView = UIImageView()
    let accountTextField = UITextField()
    let loginAccountTextField = UITextField()
    let passwordTextField = UITextField()
    let websiteTextField = UITextField()
    let saveButton = UIButton()
    let cancelButton = UIButton()
    let addButton = UIButton()
    let backButton = UIButton()
    let titleLabel = UILabel()
    let content = UIView()
    var noPasswordView = NoView(text: "There is No Account", description: "You don't have any account yet.", image: "img_password")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createUI()
    }
    
    private func createUI() {
        fetchDataFromCoreData()
        view.backgroundColor = .headercolor
        
//        textField.textAlignment = .left
//        textField.contentVerticalAlignment = .top
        
        //ContentView
        content.backgroundColor = .white
        content.layer.cornerRadius = 15
        content.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        view.addSubview(content)
        content.backgroundColor = .homecontainercolor
        content.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(79)
            make.left.right.bottom.equalToSuperview()
        }
        
        backButton.setImage(UIImage(named: "btn_back"), for: .normal)
        backButton.configuration = .plain()
        view.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
        }
        
        titleLabel.text = "Secret Password"
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
        titleLabel.font = Font.custom(size: 25, fontWeight: .Medium)
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(backButton.snp.right).offset(50)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.centerY.equalTo(backButton.snp.centerY)
        }
        
        addButton.setImage(UIImage(named: "btn_add"), for: .normal)
        addButton.configuration = .plain()
        view.addSubview(addButton)
        addButton.snp.makeConstraints { make in
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.centerY.equalTo(titleLabel.snp.centerY)
        }
        
        if passwordArray.isEmpty {
            content.addSubview(noPasswordView)
            noPasswordView.snp.makeConstraints { make in
                make.centerX.equalTo(content.snp.centerX)
                make.top.equalTo(content.snp.top).offset(100)
            }
        } else {
            
            searchBar.placeholder = "Search"
            searchBar.setImage(UIImage(), for: .search, state: .normal)
            searchBar.searchBarStyle = .minimal
            if let textfield = self.searchBar.value(forKey: "searchField") as? UITextField {
                
                textfield.backgroundColor = .white
            }
            searchBar.delegate = self
            content.addSubview(searchBar)
            searchBar.snp.makeConstraints { make in
                make.top.equalTo(content.snp.top).offset(30)
                make.left.equalTo(content.snp.left).offset(30)
                make.right.equalTo(content.snp.right).offset(-30)
                make.height.equalTo(50)
            }
            
            content.addSubview(passwordTableView)
            passwordTableView.layer.cornerRadius = 10
            passwordTableView.backgroundColor = .homecontainercolor
            passwordTableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            passwordTableView.snp.makeConstraints { make in
                make.top.equalTo(searchBar.snp.bottom)
                make.left.right.bottom.equalToSuperview()
            }
            
            swipeAction()
            
        }
        
        configureFunctions()
        
    }
    func swipeAction() {
        passwordTableView.trailingSwipeActions = [
            SwipeAction(title: "Delete", color: .red, action: { [self] object, indexPath in
                CoreDataManager.deleteData(container: "Vault", entity: "Password", searchKey: "id", searchValue: "\(object.id)")
                passwordArray.remove(at: indexPath.row)
                self.passwordTableView.objects = passwordArray
                
                if passwordArray.isEmpty {
                    self.passwordTableView.isHidden = true
                    self.searchBar.isHidden = true
                    self.content.addSubview(self.noPasswordView)
                    noPasswordView.snp.remakeConstraints { make in
                        make.centerX.equalTo(content.snp.centerX)
                        make.top.equalTo(content.snp.top).offset(100)
                        
                    }
                }
            })
        ]
    }
    
    func configureFunctions() {
        addButton.addAction { [self] in
            if self.passwordTableView.objects.isEmpty {
                self.noPasswordView.isHidden = true
            } else {
                self.searchBar.isHidden = true
                self.passwordTableView.isHidden = true
            }
            
            passwordImageView.contentMode = .scaleAspectFit
            passwordImageView.clipsToBounds = true
            content.addSubview(passwordImageView)
            self.passwordImageView.snp.makeConstraints { make in
                make.top.equalTo(self.content.snp.top).offset(30)
                make.left.equalTo(self.content.snp.left).offset(15)
                make.right.equalTo(self.content.snp.right).inset(250)
                make.height.equalTo(100)
            }
            
            accountTextField.placeholder = "Name of the Account"
            accountTextField.borderStyle = .roundedRect
            content.addSubview(accountTextField)
            accountTextField.delegate = self
            self.accountTextField.snp.makeConstraints { make in
                make.top.equalTo(self.passwordImageView.snp.bottom).offset(60)
                make.left.equalTo(self.content.snp.left).offset(20)
                make.right.equalTo(self.content.snp.right).offset(-20)
                make.height.equalTo(50)
            }
            
            loginAccountTextField.placeholder = "Login Account"
            loginAccountTextField.borderStyle = .roundedRect
            loginAccountTextField.autocapitalizationType = .none
            content.addSubview(loginAccountTextField)
            self.loginAccountTextField.snp.makeConstraints { make in
                make.top.equalTo(self.accountTextField.snp.bottom).offset(15)
                make.left.equalTo(self.content.snp.left).offset(20)
                make.right.equalTo(self.content.snp.right).offset(-20)
                make.height.equalTo(50)
            }
            
            passwordTextField.placeholder = "Password"
            passwordTextField.isSecureTextEntry = true
            passwordTextField.borderStyle = .roundedRect
            content.addSubview(passwordTextField)
            self.passwordTextField.snp.makeConstraints { make in
                make.top.equalTo(self.loginAccountTextField.snp.bottom).offset(15)
                make.left.equalTo(self.content.snp.left).offset(20)
                make.right.equalTo(self.content.snp.right).offset(-20)
                make.height.equalTo(50)
            }
            
            websiteTextField.placeholder = "Website"
            websiteTextField.borderStyle = .roundedRect
            websiteTextField.autocapitalizationType = .none
            content.addSubview(websiteTextField)
            self.websiteTextField.snp.makeConstraints { make in
                make.top.equalTo(self.passwordTextField.snp.bottom).offset(15)
                make.left.equalTo(self.content.snp.left).offset(20)
                make.right.equalTo(self.content.snp.right).offset(-20)
                make.height.equalTo(50)
            }
            
            saveButton.setTitle("Save", for: .normal)
            saveButton.backgroundColor = .systemBlue
            saveButton.layer.cornerRadius = 10
            saveButton.setTitleColor(.white, for: .normal)
            content.addSubview(saveButton)
            self.saveButton.snp.makeConstraints { make in
                make.top.equalTo(self.websiteTextField.snp.bottom).offset(20)
                make.right.equalTo(self.content.snp.right).offset(-20)
                make.height.equalTo(51)
                make.width.equalTo(160)
            }
            
            cancelButton.setTitle("Cancel", for: .normal)
            cancelButton.backgroundColor = .white
            cancelButton.layer.cornerRadius = 10
            cancelButton.setTitleColor(.black, for: .normal)
            content.addSubview(cancelButton)
            self.cancelButton.snp.makeConstraints { make in
                make.top.equalTo(self.websiteTextField.snp.bottom).offset(20)
                make.left.equalTo(self.content.snp.left).offset(20)
                make.height.equalTo(51)
                make.width.equalTo(174)
                make.right.equalTo(self.saveButton.snp.left).offset(-20)
            }
            
            self.saveButton.addAction {
                guard let imageData = self.passwordImageView.image?.pngData() else { return }
                CoreDataManager.saveData(container: "Vault", entity: "Password", attributeDict: [
                    "id": UUID(),
                    "account_name": self.accountTextField.text!,
                    "image": imageData,
                    "login_account": self.loginAccountTextField.text!,
                    "password": self.passwordTextField.text!,
                    "website": self.websiteTextField.text!
                ])
                
                
                self.accountTextField.text = ""
                self.loginAccountTextField.text = ""
                self.passwordTextField.text = ""
                self.websiteTextField.text = ""
                self.passwordImageView.image = UIImage(named: "")
                self.dismiss(animated: true)
            }
            
            self.cancelButton.addAction {
                self.dismiss(animated: true)
            }
            
        }
        
        self.backButton.addAction {
            self.dismiss(animated: true)
        }
    }
}


