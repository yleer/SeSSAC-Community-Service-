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
    }
    
    
}
