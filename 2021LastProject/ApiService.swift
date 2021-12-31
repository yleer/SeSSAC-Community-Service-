//
//  ApiService.swift
//  2021LastProject
//
//  Created by Yundong Lee on 2021/12/31.
//

import Foundation


class ApiService {
    
    static func register(username: String, password: String, email: String ) {
        
        let url = URL(string: "http://test.monocoding.com:1231/auth/local/register")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = "username=\(username)&password=\(password)&email=\(email)".data(using: .utf8,allowLossyConversion: false)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                print("error occured", error)
                return
            }
            
            guard let data = data else {
                print("no data")
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                print("response error")
                return
            }
            
            guard response.statusCode == 200 else {
                print("status code error")
                return
            }
            
            do {
                let data = try JSONDecoder().decode(User.self, from: data)
                print(data)
            }catch{
                print("error decoding data")
            }
        }.resume()
    }
    
}
