//
//  AddPosterViewModel.swift
//  2021LastProject
//
//  Created by Yundong Lee on 2021/12/31.
//

import Foundation

class AddPosterViewModel {
    let posterText: Observalble<String> = Observalble("")
    
    func addPost() {
        if let token = UserDefaults.standard.string(forKey: "token") {
            ApiService.post(token: token, text: posterText.value) { error in
                if let error = error {
                    print("error occured while posting", error)
                    return
                }
                
                print("add succed")
            }
        }
        
    }
}
