//
//  ChangePasswordView.swift
//  2021LastProject
//
//  Created by Yundong Lee on 2022/01/04.
//

import UIKit
import SnapKit

class ChangePasswordView: UIView, ViewRepresentable {
    
    
    let confirmButton = UIButton()
    let currentPassword = UITextField()
    let newPasswordTextField = UITextField()
    let checkPasswordTextField = UITextField()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpView() {
        addSubview(confirmButton)
        addSubview(currentPassword)
        addSubview(newPasswordTextField)
        addSubview(checkPasswordTextField)
        backgroundColor = .white
        currentPassword.placeholder = "기존 비밀번호를 입력해주세요."
        newPasswordTextField.placeholder = "새 비밀번호를 입력해주세요."
        checkPasswordTextField.placeholder = "비밀번호 확인"
        confirmButton.backgroundColor = .green
    }
    
    func setUpConstraints() {
        currentPassword.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
        newPasswordTextField.snp.makeConstraints { make in
            make.top.equalTo(currentPassword.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
        
        checkPasswordTextField.snp.makeConstraints { make in
            make.top.equalTo(newPasswordTextField.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
        
        confirmButton.snp.makeConstraints { make in
            make.top.equalTo(checkPasswordTextField.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
        
    }
}
