//
//  BoardCell.swift
//  2021LastProject
//
//  Created by Yundong Lee on 2021/12/31.
//

import UIKit

class BoardCell: UITableViewCell, ViewRepresentable {
  
    let writer = UILabel()
    let content = UILabel()
    let date = UILabel()

    let line = UIView()
    
    let commentLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpView()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpView() {
        addSubview(writer)
        addSubview(content)
        addSubview(date)
        
        addSubview(line)
        addSubview(commentLabel)
        line.backgroundColor = .gray
        
        content.font = UIFont.systemFont(ofSize: 22)
        
        writer.layer.cornerRadius = 5
        writer.backgroundColor = .systemGray2
    }
    
    func setUpConstraints() {
        writer.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview().offset(12)
            make.height.equalTo(25)
        }
        
        content.snp.makeConstraints { make in
            make.top.equalTo(writer.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-4)
            make.height.equalTo(25)
        }
        
        date.snp.makeConstraints { make in
            make.top.equalTo(content.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-4)
            make.height.equalTo(20)
        }
        
        line.snp.makeConstraints { make in
            make.top.equalTo(date.snp.bottom).offset(12)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
        
        commentLabel.snp.makeConstraints { make in
            make.top.equalTo(line.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-4)
            make.height.equalTo(20)
        }
        
    }
    
}
