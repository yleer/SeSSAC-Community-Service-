//
//  AddPosterViewModel.swift
//  2021LastProject
//
//  Created by Yundong Lee on 2021/12/31.
//

import Foundation

class AddPosterViewModel {
    let posterText: Observalble<String> = Observalble("")
    
    func addPost(completion: @escaping (_ result : Bool) -> Void) {
        if let token = UserDefaults.standard.string(forKey: "token") {
            ApiService.post(token: token, text: posterText.value) { error in
                DispatchQueue.main.async {
                    if let error = error {
                        print("error occured while posting", error)
                        completion(false)
                        return
                    }
                    completion(true)
                }
                
            }
        }
    }
    
    func editPost(postId: Int, completion: @escaping (PosterElement) -> Void) {
        if let token = UserDefaults.standard.string(forKey: "token") {
        
            ApiService.editPost(token: token, postId: postId, text: posterText.value) { poster, error in
                if let error = error {
                    print("error occured while posting", error)
                    return
                }
                completion(poster!)
                print("add succed")
            }
        }
    }
    
    func getComment(commentId: Int, completion: @escaping (String, Int) -> Void) {
        if let token = UserDefaults.standard.string(forKey: "token") {

            ApiService.searchComment(token: token, commentId: commentId){ comment, error in
                if let error = error {
                    print("error occured while posting", error)
                    return
                }
                completion(comment!.comment, comment!.post.id)
               
            }
        }
    }
    
    func editComment(commentId: Int, postId: Int, text: String) {
        if let token = UserDefaults.standard.string(forKey: "token") {

            ApiService.editComment(token: token, commentId: commentId, postId: postId, text: text) { error in
                if let error = error {
                    print("error occured while editing comment", error)
                    return
                }else{
                    print("hood?")
                }
            }
        }
    }
}
