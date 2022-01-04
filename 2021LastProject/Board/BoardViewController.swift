//
//  BoardViewController.swift
//  2021LastProject
//
//  Created by Yundong Lee on 2021/12/31.
//


import UIKit

class BoardViewController: UIViewController {
    
    let mainView = BoardView()
    let viewModel = BoardViewModel()
    
    override func loadView() {
        super.loadView()
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.register(BoardCell.self, forCellReuseIdentifier: "BoardCell")
        
        mainView.addPostButton.addTarget(self, action: #selector(addPostButtonClicked), for: .touchUpInside)
        

        viewModel.getPoster {
            DispatchQueue.main.async {
                self.mainView.tableView.reloadData()
            }
        }
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshData)),
            UIBarButtonItem(barButtonSystemItem: .rewind, target: self, action: #selector(segueToChangePasswordVC))
        ]
    }
    
    @objc func segueToChangePasswordVC() {
        let vc = ChangePasswordViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func refreshData(){
        viewModel.getPoster {
            DispatchQueue.main.async {
                self.mainView.tableView.reloadData()
            }
        }
    }
    
    
    @objc func addPostButtonClicked() {
        let vc = AddPosterViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension BoardViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        viewModel.cellForRowAt(tableView, cellForRowAt: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        180
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let poster = viewModel.didSelectRowAt(didSelectRowAt: indexPath)
        let vc = DetailPostViewController()
        vc.poster = poster
        navigationController?.pushViewController(vc, animated: true)
    }    
}
