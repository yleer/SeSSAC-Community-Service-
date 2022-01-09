//
//  LoginModel.swift
//  2021LastProject
//
//  Created by Yundong Lee on 2021/12/30.
//

import UIKit

class RegisterViewModel {
    var email: Observalble<String> = Observalble("")
    var nickName: Observalble<String> = Observalble("")
    var password: Observalble<String> = Observalble("")
    var passwordCheck: Observalble<String> = Observalble("")
    
    
    // user 정보를 가져와서 그 정보 사용하고 싶음.
    func register(completion: @escaping (String) -> Void) -> RegisterError? {
        if isValidEmail(email.value) && nickName.value.count > 4 && password.value == passwordCheck.value && password.value.count != 0  {
            ApiService.register(username: nickName.value, password: password.value, email: email.value) { user, error in
                if let error = error {
                    switch error {
                    case .invalidResponse:
                        completion("Invalid Response")
                    case .noData:
                        completion("No Data")
                    case .failed:
                        completion("Failed")
                    case .invalidData(_):
                        completion("Invaild Data")
                    case .invalidStatusCode(_,  _):
                        completion("Invalid Status code")
                    }
                    
                }else{
                    print("success")
                    UserDefaults.standard.set(user!.jwt, forKey: "token")
                    UserDefaults.standard.set(user!.user.username, forKey: "userName")
                    UserDefaults.standard.set(user!.user.id, forKey: "id")
                    UserDefaults.standard.set(user!.user.email, forKey: "email")
                }
            }
        }else {
            if !isValidEmail(email.value){
                return .notEmailFormat
            }else if nickName.value.count < 5 {
                return .nickNameShort
            }else{
                return .passwordMismatch
            }
        }
        return nil
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}

enum RegisterError: Error {
    
    case notEmailFormat
    case nickNameShort
    case passwordMismatch
    
}


