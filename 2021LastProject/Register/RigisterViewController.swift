//
//  LoginViewController.swift
//  2021LastProject
//
//  Created by Yundong Lee on 2021/12/30.
//

import UIKit

class RigisterViewController: UIViewController {
    
    let mainView = RegisterView()
    let viewModel = RegisterViewModel()
    
    override func loadView() {
        super.loadView()
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "새싹농장 가입하기"
        
        binding()
        
        mainView.emailTextField.addTarget(self, action: #selector(emailChanged), for: .editingChanged)
        mainView.nickNameTextField.addTarget(self, action: #selector(nickNameChanged), for: .editingChanged)
        mainView.passwordTextField.addTarget(self, action: #selector(passwordChanged), for: .editingChanged)
        mainView.passwordCheckTextField.addTarget(self, action: #selector(passwordCheckChanged), for: .editingChanged)
        
        mainView.registerButton.addTarget(self, action: #selector(registerButtonClicked), for: .touchUpInside)
    }
    
    
    
    @objc func emailChanged(_ textField: UITextField) {
        viewModel.email.value = textField.text ?? ""
    }
    
    @objc func nickNameChanged(_ textField: UITextField) {
        viewModel.nickName.value = textField.text ?? ""
    }
        
    @objc func passwordChanged(_ textField: UITextField) {
        viewModel.password.value = textField.text ?? ""
    }
    
    @objc func passwordCheckChanged(_ textField: UITextField) {
        viewModel.passwordCheck.value = textField.text ?? ""
    }
    
    @objc func registerButtonClicked () {
        viewModel.register()
    }
    
    
    
    
    
    
    
    
    
    func binding() {
        viewModel.email.bind { text in
            self.mainView.emailTextField.text = text
        }
        
        viewModel.nickName.bind { text in
            self.mainView.nickNameTextField.text = text
        }
        
        viewModel.password.bind { text in
            self.mainView.passwordTextField.text = text
        }
        
        viewModel.passwordCheck.bind { text in
            self.mainView.passwordCheckTextField.text = text
        }
    }
    
}
