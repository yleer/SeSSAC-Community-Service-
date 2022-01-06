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
    var start = 1
    var limit = 10
    
    override func loadView() {
        super.loadView()
        self.view = mainView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getPosters()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.register(BoardCell.self, forCellReuseIdentifier: "BoardCell")
        
        mainView.addPostButton.addTarget(self, action: #selector(addPostButtonClicked), for: .touchUpInside)
        mainView.tableView.prefetchDataSource = self
        

        getPosters()
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshData)),
            UIBarButtonItem(barButtonSystemItem: .rewind, target: self, action: #selector(segueToChangePasswordVC))
        ]
    }
    
    func getPosters() {
        viewModel.getPoster(start: start, limit: limit) {
            DispatchQueue.main.async {
                self.mainView.tableView.reloadData()
            }
        }
    }
    
    @objc func segueToChangePasswordVC() {
        let vc = ChangePasswordViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func refreshData(){
        getPosters()
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
        let stroyBoard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let vc = stroyBoard.instantiateViewController(withIdentifier: "DetailPostViewController") as? DetailPostViewController else { return }
        vc.poster = poster
        navigationController?.pushViewController(vc, animated: true)
    }    
}

extension BoardViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if viewModel.posters.count - 2 == indexPath.row{
                start += limit
                getPosters()
                print("fehcing", indexPaths)
            }
        }
    }


    // 사용자가 스크롤 빨리 해서 데이터 필요 없으면 다운 취소
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        print("취소\(indexPaths)")
    }
}
