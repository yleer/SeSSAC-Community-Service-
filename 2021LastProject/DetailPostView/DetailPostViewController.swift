//
//  DetailPostViewController.swift
//  2021LastProject
//
//  Created by Yundong Lee on 2022/01/01.
//

import UIKit
import Toast


protocol PassPosterDataDelegate {
    func sendPosterData(poster: PosterElement?)
}

class DetailPostViewController: UIViewController, PassPosterDataDelegate {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadComemnts()
    }
    
    
    func sendPosterData(poster: PosterElement?) {
        self.poster = poster
        tableView.reloadData()
    }
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var commentTextField: UITextField!
    
    var poster: PosterElement?
    let viewModel = DetailPostViewModel()
    var comments: Comments = []
    
    func loadComemnts() {
        viewModel.viewComments(id: poster!.id) {
            self.comments = $0
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func setUp() {
        let doneButton = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        doneButton.backgroundColor = .gray
        doneButton.setTitle("hh", for: .normal)
        commentTextField.rightView = doneButton
        commentTextField.rightViewMode = .always
        
        navigationItem.rightBarButtonItem =  UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editPost))
        
        doneButton.addTarget(self, action: #selector(createComment), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadComemnts()
        tableView.rowHeight = UITableView.automaticDimension
        setUp()
    }
    
    @objc func editPost() {
           if let currentId = UserDefaults.standard.string(forKey: "id") {
               if Int(currentId)! == poster!.user.id{
                   let alertVC = UIAlertController(title: "글을 어떻게 할까요?", message: "", preferredStyle: .actionSheet)
                   let editButton = UIAlertAction(title: "글을 수정하시겠습니까?", style: .default, handler: {_ in
                       let vc = AddPosterViewController()
                       vc.previousText = self.poster!.text
                       vc.id = self.poster!.id
                       vc.delegate = self
                       self.navigationController?.pushViewController(vc, animated: true)
                   })
                   let deleteButton = UIAlertAction(title: "글을 삭제하시겠습니까?", style: .destructive, handler: {_ in
                       self.viewModel.deletePost(id: self.poster!.id) {
                           self.navigationController?.popViewController(animated: true)
                       }
                   })
                   let cancelButton = UIAlertAction(title: "취소", style: .cancel, handler: nil)
   
                   alertVC.addAction(editButton)
                   alertVC.addAction(deleteButton)
                   alertVC.addAction(cancelButton)
   
                   present(alertVC, animated: true, completion: nil)
   
               }else{
                   self.view.makeToast("작성자가 아니면 수정이 불가능합니다.")
               }
           }
       }
    
    @objc func createComment() {
        if let text = commentTextField.text, text.count > 0 {
            viewModel.writeComment(comment: text, id: poster!.id) { comment in
                print(comment)
            }
            if comments.count != 0 {
                let indexPath = IndexPath(row: comments.count - 1, section: 1)
                tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
            }
            loadComemnts()
            commentTextField.text = ""
        }else{
            self.view.makeToast("글자를 입력해 주세요.")
        }
        
    }
}



extension DetailPostViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRowsInSection(numberOfRowsInSection: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCommentTableViewCell", for: indexPath) as? DetailCommentTableViewCell else {return UITableViewCell() }

            let date = poster!.createdAt
            let index = date.firstIndex(of: "T")!
            cell.userNickName.text = poster!.user.username
            cell.contentLabel.text = poster!.text
            cell.dateLabel.text = "\(date[..<index])"
            cell.numberOfCommentLabel.text = "댓글 \(comments.count)"
            return cell
        }else{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "DetailPostTableViewCell", for: indexPath) as? DetailPostTableViewCell else {return UITableViewCell() }

            cell.comment.text = comments[indexPath.row].comment
            cell.nickName.text = comments[indexPath.row].user.username
            cell.button.addTarget(self, action: #selector(editCommentButtonClicked), for: .touchUpInside)
            cell.button.tag = comments[indexPath.row].id
            return cell
        }
    }
    
    @objc func editCommentButtonClicked(_ button: UIButton) {
        
        var selectedComment: Comment2 = comments[0]
        
        for comment in comments {
            if comment.id == button.tag {
                selectedComment = comment
                break
            }
        }
        
        if selectedComment.user.id == UserDefaults.standard.integer(forKey: "id") {
            let alertVC = UIAlertController(title: "댓글에 대하여 어떤작업을 수행하시겠습니까?", message: "", preferredStyle: .actionSheet)
            let editButton = UIAlertAction(title: "수정하기", style: .default, handler: { _ in
                let vc = AddPosterViewController()
                vc.commentNumber = button.tag
                self.navigationController?.pushViewController(vc, animated: true)
            })
            let deleteButton = UIAlertAction(title: "삭제하기", style: .destructive, handler: { _ in
                self.viewModel.deleteComment(id: button.tag) { result in
                    DispatchQueue.main.async {
                        if result{
                            self.viewModel.viewComments(id: self.poster!.id) {
                                self.comments = $0
                                DispatchQueue.main.async {
                                    self.tableView.reloadData()
                                }
                            }
                            self.view.makeToast("댓글이 삭제되었습니다..")
                            
                        }else{
                            self.view.makeToast("작성자가 아니면 댓글 삭제가 불가능합니다.")
                        }
                    }
                    
                }
            })
            
            let cancelButton = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            
            alertVC.addAction(editButton)
            alertVC.addAction(deleteButton)
            alertVC.addAction(cancelButton)
            
            present(alertVC, animated: true, completion: nil)
            
        }else {
            self.view.makeToast("본인 댓글만 수정 가능합니다.")
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return tableView.rowHeight
        }
        return 80
    }
}


//{
//
//    var poster: PosterElement!
//    let mainView = DetailPostView()
//    let viewModel = DetailPostViewModel()
//    var comments: Comments = []
//
//    override func loadView() {
//        super.loadView()
//        self.view = mainView
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        mainView.tableView.delegate = self
//        mainView.tableView.dataSource = self
//        mainView.tableView.register(DetailCommentTableViewCell.self, forCellReuseIdentifier: "DetailCommentTableViewCell")
//        mainView.tableView.register(DetailPostTableViewCell.self, forCellReuseIdentifier: "DetailPostTableViewCell")
//
//        viewModel.writtenComment.bind { text in
//            self.mainView.commentTextField.text = text
//        }
//
//        mainView.commentTextField.addTarget(self, action: #selector(writeComment), for: .editingDidEndOnExit)
//
//        viewModel.poster = poster
//        viewModel.viewComments(id: poster.id) {
//            self.comments = $0
//            DispatchQueue.main.async {
//                self.mainView.tableView.reloadData()
//            }
//        }
//        print("포스터 아이디: ", poster.id)
//        navigationItem.rightBarButtonItem =  UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editPost))
//    }
//
//    @objc func editPost() {
//
//        if let currentId = UserDefaults.standard.string(forKey: "id"){
//            if Int(currentId)! == poster.user.id{
//                let alertVC = UIAlertController(title: "글을 어떻게 할까요?", message: "", preferredStyle: .actionSheet)
//
//
//                let editButton = UIAlertAction(title: "글을 수정하시겠습니까?", style: .default, handler: {_ in
//                    let vc = AddPosterViewController()
//                    vc.previousText = self.poster.text
//                    vc.id = self.poster.id
//                    self.navigationController?.pushViewController(vc, animated: true)
//                })
//                let deleteButton = UIAlertAction(title: "글을 삭제하시겠습니까?", style: .destructive, handler: {_ in
//                    self.viewModel.deletePost(id: self.poster.id) {
//                        self.navigationController?.popViewController(animated: true)
//                    }
//                })
//
//
//                let cancelButton = UIAlertAction(title: "취소", style: .cancel, handler: nil)
//
//                alertVC.addAction(editButton)
//                alertVC.addAction(deleteButton)
//                alertVC.addAction(cancelButton)
//
//                present(alertVC, animated: true, completion: nil)
//
//            }else{
//                self.view.makeToast("작성자가 아니면 수정이 불가능합니다.")
//            }
//        }
//    }
//
//    @objc func commentEditButtonClicked() {
//        print("gell")
//    }
//
//    @objc func writeComment(_ textField: UITextField) {
//        print(poster.id)
//
//        if let text = textField.text {
//            viewModel.writeComment(comment: text, id: poster.id)
//        }
//
//    }
//    var cells: [DetailPostTableViewCell] = []
////    User2(id: 5, username: "hue", email: "hue@memolease.com", provider: "local", confirmed: true, blocked: Optional(false), role: 1, createdAt: "2021-12-30T10:00:34.057Z", updatedAt: "2021-12-30T10:00:34.073Z")
//}
//
//
//
//extension DetailPostViewController: UITableViewDelegate, UITableViewDataSource {
//    func numberOfSections(in tableView: UITableView) -> Int {
//        2
//    }
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        viewModel.numberOfRowsInSection(numberOfRowsInSection: section)
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        if indexPath.section == 0 {
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCommentTableViewCell", for: indexPath) as? DetailCommentTableViewCell else {return UITableViewCell() }
//
//            let date = poster.createdAt
//            let index = date.firstIndex(of: "T")!
//            cell.userNickName.text = poster.user.username
//            cell.contentLabel.text = poster.text
//            cell.dateLabel.text = "\(date[..<index])"
//            cell.numberOfCommentLabel.text = "댓글 \(poster.comments.count)"
//            return cell
//        }else{
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: "DetailPostTableViewCell", for: indexPath) as? DetailPostTableViewCell else {return UITableViewCell() }
//
//            cell.comment.text = comments[indexPath.row].comment
//            cell.nickName.text = comments[indexPath.row].user.username
//            cell.buttonAction = { [unowned self] in
//                print("신고")
//            }
//            cells.append(cell)
//            return cell
//        }
//
//
//
////        let tmp = viewModel.cellForRowAt(tableView, cellForRowAt: indexPath)
////        if let cell = tmp as? DetailPostTableViewCell {
////            cell.button.addTarget(self, action: #selector(commentEditButtonClicked), for: .touchUpInside)
////            return cell
////        }
////
////        return tmp
//
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if indexPath.section == 0 {
//            return mainView.tableView.rowHeight
//        }
//        return 80
//    }
//}
//


