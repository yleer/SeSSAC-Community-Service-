//
//  BoardView.swift
//  2021LastProject
//
//  Created by Yundong Lee on 2021/12/31.
//

import UIKit
import SnapKit

class BoardView: UIView, ViewRepresentable {
    
    let tableView = UITableView()
    let addPostButton = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpView() {
        backgroundColor = .white
        addSubview(tableView)
        addSubview(addPostButton)
        addPostButton.setTitle("+", for: .normal)
        addPostButton.backgroundColor = .green
        addPostButton.layer.cornerRadius = 15
    }
    
    func setUpConstraints() {
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.leading.equalTo(safeAreaLayoutGuide)
            make.trailing.equalTo(safeAreaLayoutGuide)
            make.bottom.equalTo(safeAreaLayoutGuide)
        }
        
        addPostButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide).offset(-30)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-15)
            make.height.equalTo(50)
            make.width.equalTo(50)
        }
        
    }
    
    
}
