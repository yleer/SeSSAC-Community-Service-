//
//  AddPosterViewModel.swift
//  2021LastProject
//
//  Created by Yundong Lee on 2021/12/31.
//

import Foundation

class AddPosterViewModel {
    let posterText: Observalble<String> = Observalble("")
    
    func addPost(completion: @escaping (Bool, String, Int?) -> Void) {
        if let token = UserDefaults.standard.string(forKey: "token") {
            ApiService.post(token: token, text: posterText.value) { error in
                DispatchQueue.main.async {
                    if let error = error {
                        switch error {
                        case .invalidResponse:
                            completion(false, "Invlid Response",nil)
                        case .noData:
                            completion(false, "No data",nil)
                        case .failed:
                            completion(false, "Failed",nil)
                        case .invalidData(let code):
                            completion(false, "Invalid Data", code)
                        case .invalidStatusCode(let code, let errorContent):
                            completion(false, errorContent, code)
                        }
                        return
                    }
                    completion(true, "Success",nil)
                }
                
            }
        }
    }
    
    func editPost(postId: Int, completion: @escaping (PosterElement?,  String?,Int?) -> Void) {
        if let token = UserDefaults.standard.string(forKey: "token") {
        
            ApiService.editPost(token: token, postId: postId, text: posterText.value) { poster, error in
                if let error = error {
                    switch error {
                    case .invalidResponse:
                        completion(nil, "Invliad Response", nil)
                    case .noData:
                        completion(nil, "No data", nil)
                    case .failed:
                        completion(nil, "Failed", nil)
                    case .invalidData(let code):
                        completion(nil, "Invlaid data", code)
                    case .invalidStatusCode(let code, let errorContent):
                        completion(nil, errorContent, code)
                    }
                    return
                }
                completion(poster!, "Success", nil)
                print("add succed")
            }
        }
    }
    
    func getComment(commentId: Int, completion: @escaping (String?, Int?, String?) -> Void) {
        if let token = UserDefaults.standard.string(forKey: "token") {

            ApiService.searchComment(token: token, commentId: commentId){ comment, error in
                if let error = error {
                    switch error {
                    case .invalidResponse:
                        completion(nil, nil, "Invlid Response")
                    case .noData:
                        completion(nil, nil, "No Data")
                    case .failed:
                        completion(nil, nil, "Failed")
                    case .invalidData(let code):
                        completion(nil, code, "Invalid Data")
                    case .invalidStatusCode(let code, let errorContent):
                        completion(nil, code, errorContent)
                    }
//                    print("error occured while posting", error)
                    return
                }
                completion(comment!.comment, comment!.post.id, nil)
               
            }
        }
    }
    
    func editComment(commentId: Int, postId: Int, text: String, completion: @escaping (Bool, String?,Int?) -> Void) {
        if let token = UserDefaults.standard.string(forKey: "token") {

            print("qqq")
            ApiService.editComment(token: token, commentId: commentId, postId: postId, text: text) { error in
                print("please")
                if let error = error {
                    switch error {
                    case .invalidResponse:
                        completion(false, "Invliad Response", nil)
                    case .noData:
                        completion(false, "No data", nil)
                    case .failed:
                        completion(false, "Failed", nil)
                    case .invalidData(let code):
                        completion(false, "Invlaid data", code)
                    case .invalidStatusCode(let code, let errorContent):
                        completion(false, errorContent, code)
                    }
                    return
                }
                print("Sdd")
                completion(true, "Success", nil)
                
            }
        }
    }
}
