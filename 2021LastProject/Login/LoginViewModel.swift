//
//  LoginViewModel.swift
//  2021LastProject
//
//  Created by Yundong Lee on 2021/12/31.
//

import Foundation

class LoginViewModel {
    var id: Observalble<String> = Observalble("")
    var pssword: Observalble<String> = Observalble("")
    
    func login(completion: @escaping (User?, String) -> Void) {
        ApiService.login(id: id.value, password: pssword.value) { user, error in
            if let error = error {
                
                switch error {
                case .invalidResponse:
                    completion(nil, "Invalid Resopose")
                case .noData:
                    completion(nil, "No Data")
                case .failed:
                    completion(nil, "Network Failed")
                case .invalidData(_):
                    completion(nil, "Invalid Data")
                case .invalidStatusCode(_, let errorContent):
                    completion(nil, errorContent)
                }
            }else{
                print(user!)
                UserDefaults.standard.set(user!.jwt, forKey: "token")
                UserDefaults.standard.set(user!.user.username, forKey: "userName")
                UserDefaults.standard.set(user!.user.id, forKey: "id")
                UserDefaults.standard.set(user!.user.email, forKey: "email")
                completion(user!, "Login Success")
            }
        }
    }
    
}
