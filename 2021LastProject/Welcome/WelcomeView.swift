//
//  WelcomeView.swift
//  2021LastProject
//
//  Created by Yundong Lee on 2021/12/30.
//

import UIKit
import SnapKit


protocol ViewRepresentable {
    func setUpView()
    func setUpConstraints()
}


class WelcomeView: UIView, ViewRepresentable{

    
    let centerImageView = UIImageView()
    let titleLabel = UILabel()
    let detailLabel = UILabel()
    
    let startButton = UIButton()
    
    let stack = UIStackView()
    let haveIdLabel = UILabel()
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
        self.addSubview(centerImageView)
        self.addSubview(titleLabel)
        self.addSubview(detailLabel)
        self.addSubview(startButton)
        self.addSubview(stack)
        
        stack.addArrangedSubview(haveIdLabel)
        stack.addArrangedSubview(loginButton)
        stack.spacing = 4
    
        
        
        backgroundColor = .white
        
        centerImageView.image = UIImage(named: "logo_ssac_clear")
        centerImageView.contentMode = .scaleAspectFill
        titleLabel.text = "당신 근처의 새싹농장"
        detailLabel.numberOfLines = 2
        detailLabel.text = "ios지식부터 바람의나라까지\n지금 SeSAC에서 함께해보세요!"
        titleLabel.textAlignment = .center
        detailLabel.textAlignment = .center
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        
        haveIdLabel.text = "이미 계정이 있나요?"
        
        startButton.setTitle("시작하기", for: .normal)
        loginButton.setTitle("로그인", for: .normal)
        
        
        startButton.backgroundColor = .green
        
        haveIdLabel.textColor = .gray
        loginButton.setTitleColor(.green, for: .normal)
    }
    
    func setUpConstraints() {
        centerImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-100)
            make.width.equalToSuperview().multipliedBy(0.4)
            make.height.equalTo(centerImageView.snp.width)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(centerImageView.snp.bottom).offset(12)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        detailLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        stack.snp.makeConstraints { make in
            make.bottom.equalTo(self.safeAreaLayoutGuide).offset(-15)
            make.centerX.equalToSuperview()
            
        }
        
        startButton.snp.makeConstraints { make in
            make.bottom.equalTo(haveIdLabel.snp.top).offset(-15)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.7)
            make.height.equalTo(55)
        }
        
    }
    
    
}
