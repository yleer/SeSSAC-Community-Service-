//
//  AddPosterViewController.swift
//  2021LastProject
//
//  Created by Yundong Lee on 2021/12/31.
//


import UIKit
import Toast

class AddPosterViewController: UIViewController {
    
    
    let mainView = AddPosterView()
    let viewModel = AddPosterViewModel()
    var previousText: String?
    var id : Int?
    var commentNumber: Int?
    var delegate: PassPosterDataDelegate?
    
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
            title = "글 수정"
            mainView.textView.text = previousText
        }
        
        if let comment = commentNumber {
            title = "댓글 수정"
            viewModel.getComment(commentId: comment) { comment, postId in
                DispatchQueue.main.async {
                    self.mainView.textView.text = comment
                    self.id = postId
                }
                
            }
        }
    }
    
    @objc func saveButtonClicked (_ button: UIButton) {
        delegate?.sendPosterData(poster: nil)
        
        if previousText == nil && commentNumber == nil {
            if let text = mainView.textView.text {
                viewModel.posterText.value = text
                viewModel.addPost { result in
                    if result {
                        self.view.makeToast("글을 작성했습니다.")
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                            self.delegate?.sendPosterData(poster: nil)
                            self.navigationController?.popViewController(animated: true)
                        }
                    }else{
                        self.view.makeToast("글 작성에 실패했습니다.")
                    }
                }
            }
        }else if previousText != nil{
            viewModel.posterText.value = mainView.textView.text
            viewModel.editPost(postId: id!) { poster in
                self.delegate?.sendPosterData(poster: poster)
            }
        }else if commentNumber != nil {
            viewModel.editComment(commentId: commentNumber!, postId: id!, text: mainView.textView.text)
            self.view.makeToast("댓글 수정을 완료했습니다.")
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
}


