//
//  WelcomeViewController.swift
//  2021LastProject
//
//  Created by Yundong Lee on 2021/12/30.
//

import UIKit

class WelcomeViewContoller: UIViewController {
    
    let mainView = WelcomeView()
    
    
    override func loadView() {
        super.loadView()
        self.view = mainView
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.startButton.addTarget(self, action: #selector(startButtonClicked), for: .touchUpInside)
        mainView.loginButton.addTarget(self, action: #selector(loginButtonClicked), for: .touchUpInside)
    }
    
    
    @objc func startButtonClicked() {
        let vc = RigisterViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func loginButtonClicked() {
        let vc = LoginViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
