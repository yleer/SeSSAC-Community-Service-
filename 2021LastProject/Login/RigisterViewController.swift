//
//  LoginViewController.swift
//  2021LastProject
//
//  Created by Yundong Lee on 2021/12/30.
//

import UIKit

class RigisterViewController: UIViewController {
    
    let mainView = RegisterView()
    
    override func loadView() {
        super.loadView()
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "새싹농장 가입하기"
        
        ApiService.register(username: "asdfasdf", password: "123123asdf", email: "asdfadsf@gasd.com")
    }
    
}
