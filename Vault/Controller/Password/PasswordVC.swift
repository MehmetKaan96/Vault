//
//  PasswordVC.swift
//  Vault
//
//  Created by Mehmet Kaan on 4.11.2023.
//

import UIKit
import NeonSDK

class PasswordVC: UIViewController {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var passwordTableView: PasswordTableView!
    var searchBar: UITextField!
    
    internal let passwordImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    internal let accountTextField: UITextField = {
       let textField = UITextField()
        textField.placeholder = "Name of the Account"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let loginAccountTextField: UITextField = {
       let textField = UITextField()
        textField.placeholder = "Login Account"
        textField.borderStyle = .roundedRect
        textField.autocapitalizationType = .none
        return textField
    }()
    
    private let passwordTextField: UITextField = {
       let textField = UITextField()
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let websiteTextField: UITextField = {
       let textField = UITextField()
        textField.placeholder = "Website"
        textField.borderStyle = .roundedRect
        textField.autocapitalizationType = .none
        return textField
    }()
    
    internal let textField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Text Here"
        tf.font = Font.custom(size: 16, fontWeight: .Regular)
        tf.borderStyle = .roundedRect
        return tf
    }()
    
    internal let descriptiontextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Text Here"
        tf.font = Font.custom(size: 16, fontWeight: .Regular)
        tf.borderStyle = .roundedRect
        return tf
    }()
    
    private let saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Save", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private let cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    let addButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "btn_add"), for: .normal)
        button.configuration = .plain()
        return button
    }()
    
    let backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "btn_back"), for: .normal)
        button.configuration = .plain()
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Secret Password"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        label.font = Font.custom(size: 25, fontWeight: .Medium)
        return label
    }()
    
    var customView: NoView!
    
    private let content: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createUI()
    }
    
    private func createUI() {
        fetchDataFromCoreData()
        view.backgroundColor = .headercolor
        view.addSubview(content)
        view.addSubview(backButton)
        view.addSubview(titleLabel)
        view.addSubview(addButton)
        
        content.addSubview(saveButton)
        content.addSubview(cancelButton)
        content.addSubview(passwordImageView)
        content.addSubview(accountTextField)
        content.addSubview(loginAccountTextField)
        content.addSubview(passwordTextField)
        content.addSubview(websiteTextField)
        
        accountTextField.delegate = self
        textField.textAlignment = .left
        textField.contentVerticalAlignment = .top
    
        content.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(79)
            make.left.right.bottom.equalToSuperview()
        }
        
        backButton.snp.makeConstraints { make in
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(backButton.snp.right).offset(50)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.centerY.equalTo(backButton.snp.centerY)
        }
        
        addButton.snp.makeConstraints { make in
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.centerY.equalTo(titleLabel.snp.centerY)
        }
        
        if passwordArray.isEmpty {
            customView = NoView(text: "There is No Account", description: "You don't have any account yet.", image: "img_password")
            content.addSubview(customView)
            customView.snp.makeConstraints { make in
                make.centerX.equalTo(content.snp.centerX)
                make.top.equalTo(content.snp.top).offset(100)
            }
        } else {
            searchBar = UITextField()
            searchBar.placeholder = "Search"
            searchBar.borderStyle = .roundedRect
            searchBar.delegate = self
            content.addSubview(searchBar)
            
            searchBar.snp.makeConstraints { make in
                make.top.equalTo(content.snp.top).offset(30)
                make.left.equalTo(content.snp.left).offset(30)
                make.right.equalTo(content.snp.right).offset(-30)
                make.height.equalTo(50)
            }
            
            passwordTableView = PasswordTableView()
            content.addSubview(passwordTableView)
            passwordTableView.layer.cornerRadius = 10
            passwordTableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            passwordTableView.snp.makeConstraints { make in
                make.top.equalTo(searchBar.snp.bottom).offset(25)
                make.left.right.bottom.equalToSuperview()
            }
        }
        
        configureFunctions()
        
    }
    
    private func configureFunctions() {
        addButton.addAction {
            if passwordArray.isEmpty {
                self.customView.isHidden = true
            } else {
                self.searchBar.isHidden = true
                self.passwordTableView.isHidden = true
            }
            
            self.passwordImageView.snp.makeConstraints { make in
                make.top.equalTo(self.content.snp.top).offset(30)
                make.left.equalTo(self.content.snp.left).offset(15)
                make.right.equalTo(self.content.snp.right).inset(250)
                make.height.equalTo(100)
            }
            
            self.accountTextField.snp.makeConstraints { make in
                make.top.equalTo(self.passwordImageView.snp.bottom).offset(60)
                make.left.equalTo(self.content.snp.left).offset(20)
                make.right.equalTo(self.content.snp.right).offset(-20)
                make.height.equalTo(50)
            }
            
            self.loginAccountTextField.snp.makeConstraints { make in
                make.top.equalTo(self.accountTextField.snp.bottom).offset(15)
                make.left.equalTo(self.content.snp.left).offset(20)
                make.right.equalTo(self.content.snp.right).offset(-20)
                make.height.equalTo(50)
            }
            
            self.passwordTextField.snp.makeConstraints { make in
                make.top.equalTo(self.loginAccountTextField.snp.bottom).offset(15)
                make.left.equalTo(self.content.snp.left).offset(20)
                make.right.equalTo(self.content.snp.right).offset(-20)
                make.height.equalTo(50)
            }
            
            self.websiteTextField.snp.makeConstraints { make in
                make.top.equalTo(self.passwordTextField.snp.bottom).offset(15)
                make.left.equalTo(self.content.snp.left).offset(20)
                make.right.equalTo(self.content.snp.right).offset(-20)
                make.height.equalTo(50)
            }
            
            self.saveButton.snp.makeConstraints { make in
                make.top.equalTo(self.websiteTextField.snp.bottom).offset(20)
                make.right.equalTo(self.view.snp.right).offset(-20)
                make.height.equalTo(51)
                make.width.equalTo(160)
            }
            
            self.cancelButton.snp.makeConstraints { make in
                make.top.equalTo(self.websiteTextField.snp.bottom).offset(20)
                make.left.equalTo(self.view.snp.left).offset(20)
                make.height.equalTo(51)
                make.width.equalTo(174)
                make.right.equalTo(self.saveButton.snp.left).offset(-20)
            }
            
            self.saveButton.addAction {
                guard let imageData = self.passwordImageView.image?.pngData() else { return }
                CoreDataManager.saveData(container: "Vault", entity: "Password", attributeDict: [
                    "account_name": self.textField.text!,
                    "image": imageData,
                    "login_account": self.loginAccountTextField.text!,
                    "password": self.passwordTextField.text!,
                    "website": self.websiteTextField.text!
                ])
                self.passwordTableView.reloadData()
            }
            
        }
    }

}
