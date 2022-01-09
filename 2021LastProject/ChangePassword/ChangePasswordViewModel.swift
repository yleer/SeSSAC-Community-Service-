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
    
    
    func changePassword(competion: @escaping (Bool, String, Int?) -> Void) {
        if let token = UserDefaults.standard.string(forKey: "token") {
            ApiService.changePassword(token: token, currentPassword: currentPassword.value, newPassword: newPassword.value, confirmNewPassword: chekcPassword.value) { error in
                DispatchQueue.main.async {
                    if let error = error {
                        switch error {
                        case .invalidResponse:
                            competion(false, "Network problem",nil)
                        case .noData:
                            competion(false, "No data found",nil)
                        case .failed:
                            competion(false, "Failed",nil)
                        case .invalidData(_):
                            competion(false, "Not good data", nil)
                        case .invalidStatusCode(let code, let errorContent):
                            competion(false, errorContent, code)
                        }
                    }else{
                        competion(true, "Succesfully Changed Password",nil)
                    }
                }
               
            }
        }
    }
}
