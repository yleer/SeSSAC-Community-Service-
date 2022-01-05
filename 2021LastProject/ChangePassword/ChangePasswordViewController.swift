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
        mainView.newPasswordTextField.addTarget(self, action: #selector(newPasswordChange), for: .editingChanged)
        mainView.currentPassword.addTarget(self, action: #selector(currentTextFieldChanged), for: .editingChanged)
        mainView.checkPasswordTextField.addTarget(self, action: #selector(checkPasswordChange), for: .editingChanged)
        mainView.confirmButton.addTarget(self, action: #selector(changePasswordButtonClicked), for: .touchUpInside)
    }
    

    @objc func changePasswordButtonClicked() {
        viewModel.changePassword { result in
            if result {
                self.view.makeToast("비밀번호 변경했습니다.")
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                    self.navigationController?.popViewController(animated: true)
                }
            }else{
                self.view.makeToast("비밀번호 변경을 실패했습니다.")
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
}
