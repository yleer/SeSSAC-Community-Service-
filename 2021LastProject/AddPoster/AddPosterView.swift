//
//  AddPosterView.swift
//  2021LastProject
//
//  Created by Yundong Lee on 2021/12/31.
//


import UIKit
import SnapKit

class AddPosterView: UIView, ViewRepresentable{
    
    let textView = UITextView()
 
    
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
        addSubview(textView)
    }
    
    func setUpConstraints() {
        
        textView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.trailing.equalTo(safeAreaLayoutGuide)
            make.leading.equalTo(safeAreaLayoutGuide)
            make.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
    
}
