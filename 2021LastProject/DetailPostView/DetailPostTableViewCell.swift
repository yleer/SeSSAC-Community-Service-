//
//  DetailPostTableViewCell.swift
//  2021LastProject
//
//  Created by Yundong Lee on 2022/01/01.
//

import UIKit

protocol CellDelegate: AnyObject {
    func cellTaped(tag: Int)
}

class DetailPostTableViewCell: UITableViewCell, ViewRepresentable {
 
    let nickName = UILabel()
    let comment = UILabel()
    let button = UIButton()
    var delegate: CellDelegate?
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpView()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc func a() {
        print("asdf")
    }
    
    func setUpView() {
        addSubview(nickName)
        addSubview(comment)
        addSubview(button)
        button.setTitle("ASdf", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(a), for: .touchUpInside)
        comment.numberOfLines = 0
    }

    func setUpConstraints() {
//        nickName.snp.makeConstraints { make in
//            make.top.equalToSuperview().offset(8)
//            make.leading.equalToSuperview().offset(8)
//            make.trailing.equalToSuperview().offset(25)
//            make.height.equalTo(30)
//        }
        
        button.snp.makeConstraints { make in
//            make.centerY.equalToSuperview()
//            make.trailing.equalToSuperview().offset(-4)
//            make.width.equalTo(40)
            make.edges.equalToSuperview()
        }
        
//        comment.snp.makeConstraints { make in
//            make.top.equalTo(nickName.snp.bottom).offset(4)
//            make.leading.equalToSuperview().offset(8)
//            make.trailing.equalToSuperview().offset(25)
//            make.bottom.equalToSuperview().offset(-8)
//        }
    }
    
    
}
