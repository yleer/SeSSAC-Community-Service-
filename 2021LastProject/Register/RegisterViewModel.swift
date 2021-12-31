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
    func register() {
        print(nickName.value, password.value, email.value)
        ApiService.register(username: nickName.value, password: password.value, email: email.value) { user, error in
            
//            print(user, error)
            if let error = error {
                print("error occured while registering", error)
            }else{
                
                print("success")
                UserDefaults.standard.set(user!.jwt, forKey: "token")
                UserDefaults.standard.set(user!.user.username, forKey: "userName")
                UserDefaults.standard.set(user!.user.id, forKey: "id")
                UserDefaults.standard.set(user!.user.email, forKey: "email")
            }
        }
    }
}



//(jwt: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTEsImlhdCI6MTY0MDkzNTU1NCwiZXhwIjoxNjQwOTM1ODU0fQ.PIBlJfonezNfhuaV5D1ohM9mmq5miRVZMlOENgc5uFw", user: _021LastProject.UserClass(id: 11, username: "Asdf", email: "kakaka@email.com"))
