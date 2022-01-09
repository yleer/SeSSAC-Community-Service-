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
        bind()
        setUp()
        addTargets()
    }
    
    func bind() {
        viewModel.posterText.bind { text in
            self.mainView.textView.text = text
        }
    }

    
    func setUp() {
        
        title = "새싹농장 글쓰기"
        if let previousText = previousText{
            title = "글 수정"
            mainView.textView.text = previousText
        }
        
        if let comment = commentNumber {
            title = "댓글 수정"
            viewModel.getComment(commentId: comment) { comment, postId, errorMessage in
                DispatchQueue.main.async {
                    if let errorMessage = errorMessage {
                        if postId == 401{
                            self.view.makeToast(errorMessage + "다시 로그인 해주세요.")
                            DispatchQueue.main.asyncAfter(wallDeadline: .now() + 0.7) {
                                guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
                                windowScene.windows.first?.rootViewController = UINavigationController(rootViewController: WelcomeViewContoller())
                                windowScene.windows.first?.makeKeyAndVisible()
                                return
                            }
                        }else{
                            self.view.makeToast(errorMessage + "수정에 실패했습니다.")
                        }
                    }else{
                        self.mainView.textView.text = comment
                        self.id = postId
                    }
                }
                
            }
        }
    }
    
    func addTargets() {
        navigationItem.rightBarButtonItem =  UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(saveButtonClicked))
    }
    
    func refreshToken() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        windowScene.windows.first?.rootViewController = UINavigationController(rootViewController: WelcomeViewContoller())
        windowScene.windows.first?.makeKeyAndVisible()
    }
    
    @objc func saveButtonClicked (_ button: UIButton) {
        delegate?.sendPosterData(poster: nil)
        // 새로운 글 작성
        if previousText == nil && commentNumber == nil {
            if let text = mainView.textView.text {
                viewModel.posterText.value = text
                viewModel.addPost { result, message, code in
                    if result {
                        self.view.makeToast(message)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                            self.delegate?.sendPosterData(poster: nil)
                            self.navigationController?.popViewController(animated: true)
                        }
                    }else{
                        if let code = code {
                            if code == 401{
                                self.view.makeToast("다시 로그인 해주세요.")
                                DispatchQueue.main.asyncAfter(wallDeadline: .now() + 0.7) {
                                    self.refreshToken()
                                }
                            }
                            self.view.makeToast("글 작성에 실패했습니다." + message)
                        }else {
                            self.view.makeToast("글 작성에 실패했습니다." + message)
                        }
                        
                    }
                }
            }
        }else if previousText != nil{
            // 글 수정
            viewModel.posterText.value = mainView.textView.text
            viewModel.editPost(postId: id!) { poster, message, code in
                DispatchQueue.main.async {
                    if let poster = poster {
                        self.view.makeToast(message)
                        self.delegate?.sendPosterData(poster: poster)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                            self.navigationController?.popViewController(animated: true)
                        }
                    }else {
                        if let code = code {
                            if code == 401 {
                                self.view.makeToast(message)
                                self.refreshToken()
                            }
                        }else {
                            self.view.makeToast(message)
                        }
                    }
                }
            }
        }else if commentNumber != nil {
            // 댓글 수정
            viewModel.editComment(commentId: commentNumber!, postId: id!, text: mainView.textView.text) { result, message, code in
                DispatchQueue.main.async {
                    if result {
                        self.view.makeToast("댓글 수정을 완료했습니다.")
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                            self.navigationController?.popViewController(animated: true)
                        }
                    }else {
                        if let code = code {
                            if code == 401 {
                                self.view.makeToast(message)
                                self.refreshToken()
                            }
                        }else {
                            self.view.makeToast(message)
                        }
                    }
                }
            } 

        }
    }
}


