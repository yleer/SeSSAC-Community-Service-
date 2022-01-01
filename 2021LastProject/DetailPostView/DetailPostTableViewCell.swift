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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpView()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setUpView() {
        addSubview(nickName)
        addSubview(comment)
        addSubview(button)
        
        comment.numberOfLines = 0
    }
    
    func setUpConstraints() {
        nickName.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(8)
            make.height.equalTo(30)
        }
        comment.snp.makeConstraints { make in
            make.top.equalTo(nickName.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().offset(-8)
        }
    }
    
    
}
