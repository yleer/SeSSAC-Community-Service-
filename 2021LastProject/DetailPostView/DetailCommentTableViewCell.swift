//
//  DetailCommentTableViewCell.swift
//  2021LastProject
//
//  Created by Yundong Lee on 2022/01/01.
//

import UIKit


class DetailCommentTableViewCell: UITableViewCell, ViewRepresentable {
  
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentLabel.sizeToFit()
    }
    let userImageView = UIImageView()
    let userNickName = UILabel()
    let dateLabel = UILabel()
    
    let divider = UIView()
    
    let contentLabel = UILabel()
    
    let contentBelowDivder = UIView()
    let numberOfCommentLabel = UILabel()
    let lastDivider = UIView()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpView()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpView() {
        addSubview(userImageView)
        addSubview(userNickName)
        addSubview(dateLabel)
        addSubview(divider)
        addSubview(contentLabel)
        addSubview(contentBelowDivder)
        addSubview(numberOfCommentLabel)
        addSubview(lastDivider)
        
        divider.backgroundColor = .systemGray
        dateLabel.font = UIFont.systemFont(ofSize: 14)
        userImageView.image = UIImage(named: "11")
        userImageView.contentMode = .scaleToFill
        contentLabel.numberOfLines = 0
        dateLabel.textColor = .systemGray
        contentLabel.font = UIFont.systemFont(ofSize: 20)
        
        contentBelowDivder.backgroundColor = .systemGray
        lastDivider.backgroundColor = .systemGray
    }
    
    func setUpConstraints() {
        
        userImageView.snp.makeConstraints { make in
            make.leading.equalTo(safeAreaLayoutGuide).offset(8)
            make.top.equalTo(safeAreaLayoutGuide).offset(4)
            make.height.equalTo(50)
            make.width.equalTo(30)
        }
        
        userNickName.snp.makeConstraints { make in
            make.leading.equalTo(userImageView.snp.trailing).offset(8)
            make.top.equalTo(safeAreaLayoutGuide).offset(4)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-4)
            make.height.equalTo(30)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(userNickName.snp.bottom).offset(4)
            make.height.equalTo(20)
            make.leading.equalTo(userImageView.snp.trailing).offset(8)
            make.trailing.equalTo(safeAreaLayoutGuide)
        }
        
        divider.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
            make.height.equalTo(1)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.leading.equalTo(safeAreaLayoutGuide).offset(8)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-4)
            make.top.equalTo(divider.snp.bottom).offset(12)
            make.height.equalTo(150) // 나중에 auto로 바꿔야됨
        }
        
        contentBelowDivder.snp.makeConstraints { make in
            make.top.equalTo(contentLabel.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
            make.height.equalTo(1)
        }
        
        numberOfCommentLabel.snp.makeConstraints { make in
            make.top.equalTo(contentBelowDivder.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview()
            make.height.equalTo(30)
        }
        
        lastDivider.snp.makeConstraints { make in
            make.top.equalTo(numberOfCommentLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
            make.height.equalTo(1)
        }
    }
}

