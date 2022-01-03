//
//  ApiService.swift
//  2021LastProject
//
//  Created by Yundong Lee on 2021/12/31.
//

import Foundation


enum APIError: Error {
    case invalidResponse
    case noData
    case failed
    case invalidData
}

class ApiService {
    
    static func register(username: String, password: String, email: String, completion: @escaping (User?, APIError?) -> Void ) {
        
        let url = URL(string: "http://test.monocoding.com:1231/auth/local/register")!
    
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
//        request.httpBody = "username=\(username)&password=\(password)&email=\(email)".data(using: .utf8,allowLossyConversion: false)
        request.httpBody = "username=\(username)&password=\(password)&email=\(email)".data(using: .utf8,allowLossyConversion: false)
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                print("error occured", error)
                completion(nil, .invalidData)
                return
            }
            
            guard let data = data else {
                print("no data")
                completion(nil, .noData)
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
//                print(response)
                completion(nil, .invalidResponse)
                return
            }
            
            guard response.statusCode == 200 else {
                print(response)
                completion(nil, .failed)
                return
            }
            
            do {
                let data = try JSONDecoder().decode(User.self, from: data)
                completion(data, nil)
            }catch{
                print("error decoding data")
            }
        }.resume()
    }
    
    
    static func login(id: String, password: String, completion: @escaping (User?, APIError?) -> Void) {
            
        let url = URL(string: "http://test.monocoding.com:1231/auth/local")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = "identifier=\(id)&password=\(password)".data(using: .utf8,allowLossyConversion: false)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                completion(nil, .invalidData)
                print(error)
                return
            }
            
            guard let data = data else {
                completion(nil, .noData)
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                completion(nil, .failed)
                return
            }
            
            guard response.statusCode == 200 else {
                print("status code error")
                completion(nil, .invalidData)
                return
            }
            
            do {
                let data = try JSONDecoder().decode(User.self, from: data)
                completion(data, nil)
            }catch{
                print("error decoding data")
            }
        }.resume()
    }
    
    
    static func board(token: String, completion: @escaping (Poster?, APIError?) -> Void) {
            
        let url = URL(string: "http://test.monocoding.com:1231/posts")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField:"Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                completion(nil, .invalidData)
                print(error)
                return
            }
            
            guard let data = data else {
                completion(nil, .noData)
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                completion(nil, .failed)
                return
            }
            
            guard response.statusCode == 200 else {
                print("status code error")
                completion(nil, .invalidData)
                return
            }
            
            do {
                let data = try JSONDecoder().decode(Poster.self, from: data)
                completion(data, nil)
            }catch{
                print("error decoding data")
            }
        }.resume()
    }
    
    static func post(token: String, text: String, completion: @escaping (APIError?) -> Void) {
        let url = URL(string: "http://test.monocoding.com:1231/posts")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(token)", forHTTPHeaderField:"Authorization")
        request.httpBody = "text=\(text)".data(using: .utf8,allowLossyConversion: false)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                completion(.invalidData)
                print(error)
                return
            }
            
            guard let _ = data else {
                completion(.noData)
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                completion(.failed)
                return
            }
            
            guard response.statusCode == 200 else {
                print("status code error")
                completion(.invalidData)
                return
            }
            completion(nil)
        }.resume()
    }
    
    static func writeComment(token: String, comment: String, postId: Int, completion: @escaping (APIError?) -> Void) {
        let url = URL(string: "http://test.monocoding.com:1231/comments")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(token)", forHTTPHeaderField:"Authorization")
        request.httpBody = "comment=\(comment)&post=\(postId)".data(using: .utf8,allowLossyConversion: false)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                completion(.invalidData)
                print(error)
                return
            }
            
            guard let _ = data else {
                completion(.noData)
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                completion(.failed)
                return
            }
            
            guard response.statusCode == 200 else {
                print("status code error")
                completion(.invalidData)
                return
            }
            completion(nil)
        }.resume()
    }
    
    static func deletePost(token: String, postId: Int, completion: @escaping (APIError?) -> Void) {
        let url = URL(string: "http://test.monocoding.com:1231/posts/\(postId)")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.setValue("Bearer \(token)", forHTTPHeaderField:"Authorization")
     
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                completion(.invalidData)
                print(error)
                return
            }
            
            guard let _ = data else {
                completion(.noData)
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                completion(.failed)
                return
            }
            
            guard response.statusCode == 200 else {
                print("status code error")
                completion(.invalidData)
                return
            }
            completion(nil)
        }.resume()
    }
    
    static func editPost(token: String, postId: Int, text: String, completion: @escaping (APIError?) -> Void) {
        let url = URL(string: "http://test.monocoding.com:1231/posts/\(postId)")!
        
    
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("Bearer \(token)", forHTTPHeaderField:"Authorization")
//        request.httpBody = "text=\(text)".data(using: .utf8,allowLossyConversion: false)
        
        let editText = EditPost(text: "잘 되나 확인하자.")
        let jsonData = try? JSONEncoder().encode(editText)
        
        request.httpBody = jsonData

        print(jsonData)
        
        URLSession.shared.uploadTask(with: request, from: jsonData) { data, response, error in
            
            
            let a = try? JSONDecoder().decode(EditPost.self, from: request.httpBody!)
            print(a)
            print(data,response,error)
            if let error = error {
                completion(.invalidData)
                print(error)
                return
            }

            guard let _ = data else {
                completion(.noData)
                return
            }

            guard let response = response as? HTTPURLResponse else {
                completion(.failed)
                return
            }
            print(response.statusCode)

            guard response.statusCode == 200 else {
                print("status code error")
                completion(.invalidData)
                return
            }

            do {
                let data = try JSONDecoder().decode(PosterElement.self, from: data!)
                print(data)

            }catch{
                print("error decoding data")
            }

            completion(nil)
        }.resume()

        
    }
}
