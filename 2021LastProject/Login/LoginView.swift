//
//  LoginView.swift
//  2021LastProject
//
//  Created by Yundong Lee on 2021/12/31.
//

import UIKit

class LoginView: UIView, ViewRepresentable {
    
    let stack = UIStackView()
    let idTextField = UITextField()
    let passwordTextField = UITextField()
    let loginButton = UIButton()
    
    
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
        stack.addArrangedSubview(idTextField)
        stack.addArrangedSubview(passwordTextField)
        stack.addArrangedSubview(loginButton)
        stack.axis = .vertical
        idTextField.placeholder = "아이디"
        passwordTextField.placeholder = "비밀번호"
        loginButton.setTitle("로그인", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.backgroundColor = .green
        self.backgroundColor = .white
        
        stack.distribution = .fillEqually
        stack.spacing = 5
        passwordTextField.isSecureTextEntry = true
        
        
    }
    
    func setUpConstraints() {
        stack.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(10)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(200)
        }
    }
    
    
}
