//
//  DetailPostView.swift
//  2021LastProject
//
//  Created by Yundong Lee on 2022/01/01.
//

import UIKit

class DetailPostView: UIView, ViewRepresentable {
 
    
    let tableView = UITableView()
    
    let commentTextField = UITextField()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpView() {
        addSubview(tableView)
        addSubview(commentTextField)
        backgroundColor = .white
        commentTextField.placeholder = "댓글을 입력해주세요."
    }
    
    func setUpConstraints() {
        
        tableView.snp.makeConstraints { make in
            make.leading.equalTo(safeAreaLayoutGuide)
            make.trailing.equalTo(safeAreaLayoutGuide)
            make.top.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.9)
        }
        
        commentTextField.snp.makeConstraints { make in
            make.leading.equalTo(safeAreaLayoutGuide).offset(8)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-8)
            make.top.equalTo(tableView.snp.bottom).offset(3)
            make.bottom.equalTo(safeAreaLayoutGuide)
        }
        
    }
    
    
}
