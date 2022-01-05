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
    
    
    func changePassword(competion: @escaping (_ text: Bool) -> Void) {
        if let token = UserDefaults.standard.string(forKey: "token") {
            ApiService.changePassword(token: token, currentPassword: currentPassword.value, newPassword: newPassword.value, confirmNewPassword: chekcPassword.value) { error in
                
                DispatchQueue.main.async {
                    if let error = error {
                        print(error)
                        competion(false)
                    }else{
                        print("password changed")
                        competion(true)
                    }
                }
               
            }
        }
        
    }
}
