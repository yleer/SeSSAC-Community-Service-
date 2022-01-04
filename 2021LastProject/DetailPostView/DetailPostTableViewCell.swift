//
//  DetailPostTableViewCell.swift
//  2021LastProject
//
//  Created by Yundong Lee on 2022/01/01.
//

import UIKit




class DetailPostTableViewCell: UITableViewCell, ViewRepresentable {
 
    let nickName = UILabel()
    let comment = UILabel()
    let button = UIButton()
    
    var buttonAction : (() -> ())?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        button.addTarget(self, action: #selector(abc), for: .allEvents)
        setUpView()
        setUpConstraints()
        button.isUserInteractionEnabled = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc func abc() {
        print("asdf")
        buttonAction?()
    }
    
    func setUpView() {
        addSubview(nickName)
        addSubview(comment)
        addSubview(button)
        button.setTitle("ASdf", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .gray
        comment.numberOfLines = 0
        
    }

    func setUpConstraints() {
        nickName.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(25)
            make.height.equalTo(30)
        }
        
        button.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-4)
            make.width.equalTo(40)
//            make.center.equalToSuperview()
//            make.height.equalTo(100)
//            make.width.equalTo(100)
        }
        
        comment.snp.makeConstraints { make in
            make.top.equalTo(nickName.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(25)
            make.bottom.equalToSuperview().offset(-8)
        }
    }
    
    
}
