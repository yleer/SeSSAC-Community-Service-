//
//  ChangePasswordViewModel.swift
//  2021LastProject
//
//  Created by Yundong Lee on 2022/01/04.
//

import Foundation
import UIKit

class ChangeViewModel {
    var currentPassword: Observalble<String> = Observalble("")
    var newPassword: Observalble<String> = Observalble("")
    var chekcPassword: Observalble<String> = Observalble("")
    
    
    func changePassword() {
        if let token = UserDefaults.standard.string(forKey: "token") {
            ApiService.changePassword(token: token, currentPassword: currentPassword.value, newPassword: newPassword.value, confirmNewPassword: chekcPassword.value) { error in
                if let error = error {
                    print(error)
                }else{
                    print("password changed")
                }
            }
        }
        
    }
}
