//
//  ApiService.swift
//  2021LastProject
//
//  Created by Yundong Lee on 2021/12/31.
//

import Foundation
import Alamofire

enum APIError: Error {
    case invalidResponse
    case noData
    case failed
    case invalidData
}

class ApiService {
    
    
    static func register(username: String, password: String, email: String, completion: @escaping (User?, APIError?) -> Void ) {
        
        var request = URLRequest(url: EndPoint.register.url)
        request.httpMethod = "POST"
        request.httpBody = "username=\(username)&password=\(password)&email=\(email)".data(using: .utf8,allowLossyConversion: false)
        URLSession.request(endPoint: request, completion: completion)
    }
    static func login(id: String, password: String, completion: @escaping (User?, APIError?) -> Void) {

        var request = URLRequest(url: EndPoint.login.url)
        request.httpMethod = "POST"
        request.httpBody = "identifier=\(id)&password=\(password)".data(using: .utf8,allowLossyConversion: false)
        
        URLSession.request(endPoint: request, completion: completion)
    }
    
    
    static func board(token: String, start: Int, limit: Int, completion: @escaping (Poster?, APIError?) -> Void) {
        var request = URLRequest(url: EndPoint.boardPageing(start: start, limit: limit).url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField:"Authorization")
        URLSession.request(endPoint: request, completion: completion)
    }
    static func writeComment(token: String, comment: String, postId: Int, completion: @escaping (APIError?) -> Void) {
        var request = URLRequest(url: EndPoint.comments(id: nil).url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(token)", forHTTPHeaderField:"Authorization")
        request.httpBody = "comment=\(comment)&post=\(postId)".data(using: .utf8,allowLossyConversion: false)
        URLSession.request(endPoint: request, completion: completion)
        
    }
    static func deletePost(token: String, postId: Int, completion: @escaping (APIError?) -> Void) {
        var request = URLRequest(url:EndPoint.board(id: postId).url)
        request.httpMethod = "DELETE"
        request.setValue("Bearer \(token)", forHTTPHeaderField:"Authorization")
     
        URLSession.request(endPoint: request, completion: completion)
       
    }
    
    static func editPost(token: String, postId: Int, text: String, completion: @escaping (PosterElement?, APIError?) -> Void) {
   
        let parameters: Parameters = [
             "text": text
         ]
    
        AF.request(EndPoint.board(id: postId).url, method: .put, parameters: parameters, headers: ["Authorization" : "Bearer \(token)"])
            .response { response in
                switch response.result {
                case .success(let value) :
                    if let value = value {
                        guard let poster = try? JSONDecoder().decode(PosterElement.self, from: value) else { return }
                        completion(poster, nil)
                    }
            
                default: return
                }
            }

        
//        var request = URLRequest(url: url)
//
//        request.setValue("Bearer \(token)", forHTTPHeaderField:"Authorization")
//        request.httpMethod = "PUT"

        
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            print(data,response,error)
//            if let error = error {
//                completion(.invalidData)
//                print(error)
//                return
//            }
//
//            guard let _ = data else {
//                completion(.noData)
//                return
//            }
//
//            guard let response = response as? HTTPURLResponse else {
//                completion(.failed)
//                return
//            }
//            print(response)
//
//            guard response.statusCode == 200 else {
//                print("status code error")
//                completion(.invalidData)
//                return
//            }
//
//            do {
//                let data = try JSONDecoder().decode(PosterElement.self, from: data!)
//                print(data)
//
//            }catch{
//                print("error decoding data")
//            }
//
//            completion(nil)
//        }.resume()
    }
    static func post(token: String, text: String, completion: @escaping (APIError?) -> Void) {
  
        var request = URLRequest(url: EndPoint.board(id: nil).url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(token)", forHTTPHeaderField:"Authorization")
        request.httpBody = "text=\(text)".data(using: .utf8,allowLossyConversion: false)
        URLSession.request(endPoint: request, completion: completion)
       
    }
    
    
    
    
    static func changePassword(token: String, currentPassword: String, newPassword: String, confirmNewPassword: String, completion: @escaping (APIError?) -> Void) {

        var request = URLRequest(url: EndPoint.changePassword.url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(token)", forHTTPHeaderField:"Authorization")
        request.httpBody = "currentPassword=\(currentPassword)&newPassword=\(newPassword)&confirmNewPassword=\(confirmNewPassword)".data(using: .utf8,allowLossyConversion: false)
        
        URLSession.request(endPoint: request, completion: completion)

    }

    
    
    
    static func deleteComment(token: String, commentId: Int, completion: @escaping (APIError?) -> Void) {
        var request = URLRequest(url: EndPoint.comments(id: commentId).url)
        request.httpMethod = "DELETE"
        request.setValue("Bearer \(token)", forHTTPHeaderField:"Authorization")
     
        URLSession.request(endPoint: request, completion: completion)
    }
    
    static func editComment(token: String, commentId: Int, postId: Int, text: String, completion: @escaping (APIError?) -> Void) {
        let parameters: Parameters = [
            "comment": text,
            "post": postId
         ]
    
        AF.request(EndPoint.comments(id: commentId).url, method: .put, parameters: parameters, headers: ["Authorization" : "Bearer \(token)"])
            .response { response in
                print(response)
            }
    }
    static func searchComment(token: String, commentId: Int,  completion: @escaping (Comment2?, APIError?) -> Void) {
        var request = URLRequest(url: EndPoint.comments(id: commentId).url)
        request.httpMethod = "GET"
        
        request.setValue("Bearer \(token)", forHTTPHeaderField:"Authorization")
     
        URLSession.request(endPoint: request, completion: completion)

    }
    static func viewComment(token: String, postId: Int, completion: @escaping (Comments?, APIError?) -> Void) {
        let url = URL(string: "http://test.monocoding.com:1231/comments?post=\(postId)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField:"Authorization")
        URLSession.request(endPoint: request, completion: completion)
    }
}
