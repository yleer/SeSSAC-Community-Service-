//
//  ChangePasswordViewController.swift
//  2021LastProject
//
//  Created by Yundong Lee on 2022/01/04.
//

import UIKit
import Toast

class ChangePasswordViewController: UIViewController {

    let mainView = ChangePasswordView()
    let viewModel = ChangeViewModel()
    
    
    override func loadView() {
        super.loadView()
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        binding()
        addTargets()
    }
    
    func binding() {
        viewModel.currentPassword.bind { text in
            self.mainView.currentPassword.text = text
        }
        viewModel.chekcPassword.bind { text in
            self.mainView.checkPasswordTextField.text = text
        }
        viewModel.newPassword.bind { text in
            self.mainView.newPasswordTextField.text = text
        }
    }
    
    func addTargets() {
        mainView.newPasswordTextField.addTarget(self, action: #selector(newPasswordChange), for: .editingChanged)
        mainView.currentPassword.addTarget(self, action: #selector(currentTextFieldChanged), for: .editingChanged)
        mainView.checkPasswordTextField.addTarget(self, action: #selector(checkPasswordChange), for: .editingChanged)
        mainView.confirmButton.addTarget(self, action: #selector(changePasswordButtonClicked), for: .touchUpInside)
    }
    

    @objc func changePasswordButtonClicked() {
        viewModel.changePassword { result, message, code in
            if let code = code {
                if code == 401 {
                    self.view.makeToast(message + "다시 로그인 해주세요.")
                    DispatchQueue.main.asyncAfter(wallDeadline: .now() + 0.7) {
                        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
                        windowScene.windows.first?.rootViewController = UINavigationController(rootViewController: WelcomeViewContoller())
                        windowScene.windows.first?.makeKeyAndVisible()
                        return
                    }
                }
            }
            if result {
                self.view.makeToast(message)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                    self.navigationController?.popViewController(animated: true)
                }
            }else{
                self.view.makeToast(message)
            }
        }
    }
    
    
    @objc func currentTextFieldChanged(_ textField: UITextField) {
        viewModel.currentPassword.value = textField.text ?? ""
    }
    
    @objc func newPasswordChange(_ textField: UITextField) {
        viewModel.newPassword.value = textField.text ?? ""
    }
    
    @objc func checkPasswordChange(_ textField: UITextField) {
        viewModel.chekcPassword.value = textField.text ?? ""
    }
    
    
   
}
