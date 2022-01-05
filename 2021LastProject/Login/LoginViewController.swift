//
//  LoginViewController.swift
//  2021LastProject
//
//  Created by Yundong Lee on 2021/12/31.
//

import UIKit

class LoginViewController: UIViewController {
    
    let mainView = LoginView()
    let viewModel = LoginViewModel()
    
    override func loadView() {
        super.loadView()
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "새싹 로그인"
        binding()
        
        mainView.idTextField.addTarget(self, action: #selector(idChagned), for: .editingChanged)
        mainView.passwordTextField.addTarget(self, action: #selector(passwordChagned), for: .editingChanged)
        mainView.loginButton.addTarget(self, action: #selector(loginButtonClicked), for: .touchUpInside)
    }
    
    
    @objc func idChagned(_ textField: UITextField) {
        viewModel.id.value = textField.text ?? ""
    }
    
    @objc func passwordChagned(_ textField: UITextField) {
        viewModel.pssword.value = textField.text ?? ""
    }
    
    @objc func loginButtonClicked() {
        viewModel.login { user, error in
            DispatchQueue.main.async {
                if user == nil{
                    let alertVC = UIAlertController(title: "로그인에 실패했습니다.", message: "\(error!)", preferredStyle: .alert)
                    let cancelButton = UIAlertAction(title: "확인", style: .cancel, handler: nil)
                    alertVC.addAction(cancelButton)
                    self.present(alertVC, animated: true, completion: nil)
                    return
                }
                guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }

                windowScene.windows.first?.rootViewController = UINavigationController(rootViewController: BoardViewController())
                windowScene.windows.first?.makeKeyAndVisible()
            }
        }
    }
    
    
    func binding() {
        viewModel.id.bind { text in
            self.mainView.idTextField.text = text
        }
        
        viewModel.pssword.bind { text in
            self.mainView.passwordTextField.text = text
        }
    }
    
}
