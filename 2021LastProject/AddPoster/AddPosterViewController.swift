//
//  AddPosterViewController.swift
//  2021LastProject
//
//  Created by Yundong Lee on 2021/12/31.
//


import UIKit

class AddPosterViewController: UIViewController {
    
    
    let mainView = AddPosterView()
    let viewModel = AddPosterViewModel()
    var previousText: String?
    var id : Int?
    
    override func loadView() {
        super.loadView()
        self.view = mainView
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "새싹농장 글쓰기"
        navigationItem.rightBarButtonItem =  UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(saveButtonClicked))
        
        viewModel.posterText.bind { text in
            self.mainView.textView.text = text
        }
        
        if let previousText = previousText{
            title = "수정"
            mainView.textView.text = previousText
        }
    }
    
    @objc func saveButtonClicked (_ button: UIButton) {
        
        if previousText == nil {
            if let text = mainView.textView.text {
                viewModel.posterText.value = text
                viewModel.addPost()
            }
        }else{
//            if let text = mainView.textView.text {
//
//            }
            
            print("editing")
            viewModel.posterText.value = mainView.textView.text
            viewModel.editPost(postId: id!)
        }
        
        
    }
}


