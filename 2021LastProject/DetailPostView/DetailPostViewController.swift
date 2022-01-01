//
//  DetailPostViewController.swift
//  2021LastProject
//
//  Created by Yundong Lee on 2022/01/01.
//

import UIKit

class DetailPostViewController: UIViewController {
    
    var poster: PosterElement!
    let mainView = DetailPostView()
    let viewModel = DetailPostViewModel()
    
    override func loadView() {
        super.loadView()
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.register(DetailCommentTableViewCell.self, forCellReuseIdentifier: "DetailCommentTableViewCell")
        
        mainView.tableView.register(DetailPostTableViewCell.self, forCellReuseIdentifier: "DetailPostTableViewCell")
        
        viewModel.writtenComment.bind { text in
            self.mainView.commentTextField.text = text
        }
        
        mainView.commentTextField.addTarget(self, action: #selector(writeComment), for: .editingDidEndOnExit)
        viewModel.poster = poster
    }
    
    @objc func writeComment(_ textField: UITextField) {
        print(poster.id)
        
        if let text = textField.text {
            viewModel.writeComment(comment: text, id: poster.id)
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
        viewModel.cellForRowAt(tableView, cellForRowAt: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 400
        }
        return 80
    }
}
