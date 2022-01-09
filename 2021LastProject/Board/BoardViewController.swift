//
//  BoardViewController.swift
//  2021LastProject
//
//  Created by Yundong Lee on 2021/12/31.
//


import UIKit
import Toast

class BoardViewController: UIViewController {
    
    let mainView = BoardView()
    let viewModel = BoardViewModel()
    var start = 0
    var limit = 10
    
    override func loadView() {
        super.loadView()
        self.view = mainView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getPosters(refrsh: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        getPosters()
    }
    
    func setUp() {
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.prefetchDataSource = self
        mainView.tableView.register(BoardCell.self, forCellReuseIdentifier: "BoardCell")
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshData)),
            UIBarButtonItem(barButtonSystemItem: .rewind, target: self, action: #selector(segueToChangePasswordVC))
        ]
        mainView.addPostButton.addTarget(self, action: #selector(addPostButtonClicked), for: .touchUpInside)
    }
    
    func tokenExpired() {
        self.view.makeToast("다시 로그인 해주세요.")
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 0.7) {
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
            windowScene.windows.first?.rootViewController = UINavigationController(rootViewController: WelcomeViewContoller())
            windowScene.windows.first?.makeKeyAndVisible()
        }
    }

    func getPosters(refrsh: Bool = false) {
        viewModel.getPoster(start: start, limit: limit, refresh: refrsh) { message, code in
            if message == nil && code == nil{
                DispatchQueue.main.async {
                    self.mainView.tableView.reloadData()
                }
            }else{
                guard let code = code else {
                    self.view.makeToast(message)
                    return
                }
                if code == 401 {
                    self.tokenExpired()
                }
            }
        }
    }
    
    @objc func segueToChangePasswordVC() {
        let vc = ChangePasswordViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func refreshData(){
        start = 0
        getPosters(refrsh: true)
        let indexPath = IndexPath(row: 0, section: 0)
        mainView.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
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
            
            if viewModel.posters.count - 2 == indexPath.row {
                print(viewModel.posters.count, indexPath.row)
                start += limit
                getPosters()
            }
        }
    }
    // 사용자가 스크롤 빨리 해서 데이터 필요 없으면 다운 취소
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
    }
}


