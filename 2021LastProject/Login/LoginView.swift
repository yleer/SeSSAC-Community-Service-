//
//  LoginView.swift
//  2021LastProject
//
//  Created by Yundong Lee on 2021/12/30.
//

import UIKit
import SnapKit

class LoginView: UIView, ViewRepresentable{

    
    let stack = UIStackView()
    
    let emailTextField = UITextField()
    let nickNameTextField = UITextField()
    let passwordTextField = UITextField()
    let passwordCheckTextField = UITextField()
    let registerButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setUpView() {
        addSubview(stack)
        
        stack.addArrangedSubview(emailTextField)
        stack.addArrangedSubview(nickNameTextField)
        stack.addArrangedSubview(passwordTextField)
        stack.addArrangedSubview(passwordCheckTextField)
        stack.addArrangedSubview(registerButton)
        
        stack.distribution = .fillEqually
        stack.spacing = 10
        stack.axis = .vertical

        backgroundColor = .white
        
        emailTextField.placeholder = "이메일을 입력해주세요."
        nickNameTextField.placeholder = "닉네임"
        passwordTextField.placeholder = "비밀번호"
        passwordCheckTextField.placeholder = "비밀번호 확인"
        registerButton.setTitle("가입하기", for: .normal)
        registerButton.setTitleColor(.white, for: .normal)
        registerButton.backgroundColor = .green
        
       
    }
    
    func setUpConstraints() {
        
        stack.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(5)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalToSuperview().multipliedBy(0.4)
        }
    }
    
    
}
