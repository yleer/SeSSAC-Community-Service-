//
//  EndPoints.swift
//  2021LastProject
//
//  Created by Yundong Lee on 2022/01/06.
//

import Foundation

enum EndPoint {
    case register
    case login
    case viewBoard
    
    case board(id:Int?)
    case comments(id:Int?)
    
    case changePassword
}

// /
// /
// /
// /

extension EndPoint {
    var url: URL {
        switch self {
        case .viewBoard:
            return .makeEndPoint("posts?_sort=created_at:desc")
        case.register:
            return .makeEndPoint("auth/local/register")
        case .login:
            return .makeEndPoint("auth/local")
        case .board(id: let id):
            if let id = id {
                return .makeEndPoint("posts/\(id)")
            }else{
                return .makeEndPoint("posts")
            }
            
        case .comments(id: let id):
            if let id = id {
                return .makeEndPoint("comments/\(id)")
            }
            return .makeEndPoint("comments")
            
        case .changePassword:
            return .makeEndPoint("custom/change-password")
        }
    }
}

extension URL {
    static let baseUrl = "http://test.monocoding.com:1231/"
    
    static func makeEndPoint(_ endPoint: String) -> URL {
        return URL(string: URL.baseUrl + endPoint)!
    }
}


extension URLSession {
    
    typealias Handler = (Data?, URLResponse?, Error?) -> Void
    
    @discardableResult
    func dataTask(_ endPoint: URLRequest, handler: @escaping Handler) ->URLSessionDataTask {
        
        let task = dataTask(with: endPoint, completionHandler: handler)
        task.resume()
        return task
    }
    
    static func request<T: Decodable>(_ session: URLSession = .shared, endPoint: URLRequest, completion: @escaping (T?, APIError?) -> Void ) {
        session.dataTask(endPoint) { data, response, error in
            DispatchQueue.main.async {
                guard error == nil else{
                    completion(nil, .failed)
                    return

                }
                guard let data = data else {
                    completion(nil, .noData)
                    return
                }

                guard let response = response as? HTTPURLResponse else {
                    completion(nil, .invalidResponse)
                    return
                }

                guard response.statusCode == 200 else {
                    completion(nil, .failed)
                    return
                }

                do{
                    let decoder = JSONDecoder()
                    let userData = try decoder.decode(T.self, from: data)
                    completion(userData, nil)
                }catch{
                    completion(nil, .invalidData)
                }
            }
        }
    }
    
    static func request (_ session: URLSession = .shared, endPoint: URLRequest, completion: @escaping (APIError?) -> Void ) {
        session.dataTask(endPoint) { data, response, error in
            DispatchQueue.main.async {
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
            

                
            }
        }
    }
    
}
