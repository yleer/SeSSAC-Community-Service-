//
//  DetailPostViewModel.swift
//  2021LastProject
//
//  Created by Yundong Lee on 2022/01/01.
//

import Foundation
import UIKit

class DetailPostViewModel {
    let writtenComment = Observalble("")
    var poster: PosterElement!
    var comments: Comments = []
    
    
    func writeComment(comment: String, id: Int, completion: @escaping (Comment?, String, Int?) -> Void) {
        if let token = UserDefaults.standard.string(forKey: "token") {
            ApiService.writeComment(token: token, comment: comment, postId: id) { error in
                if let error = error {
                    switch error {
                    case .invalidResponse:
                        completion(nil, "Invalid Data", nil)
                    case .noData:
                        completion(nil, "No data", nil)
                    case .failed:
                        completion(nil, "failed", nil)
                    case .invalidData(let code):
                        completion(nil, "invalid data", code)
                    case .invalidStatusCode(let code, let errorContent):
                        completion(nil, errorContent, code)
                    }
                    return
                }
                completion(Comment(id: 2, comment: "sdfg", user: 2, post: 2, createdAt: "gfd", updatedAt: "SDgf"), "success", nil)
            }
        }
    }
    
    func deletePost(id: Int, completion: @escaping (Bool, String, Int?) -> Void){
        if let token = UserDefaults.standard.string(forKey: "token") {
            ApiService.deletePost(token: token, postId: id) { error in
                if let error = error {
                    switch error {
                    case .invalidResponse:
                        completion(false,"Invalid Data", nil)
                    case .noData:
                        completion(false,"No data", nil)
                    case .failed:
                        completion(false,"failed", nil)
                    case .invalidData(let code):
                        completion(false,"invalid data", code)
                    case .invalidStatusCode(let code, let errorContent):
                        completion(false,errorContent, code)
                    }
                    return
                }
                DispatchQueue.main.async {
                    completion(true,"success" , nil)
                }
            }
        }
    }
    
    func deleteComment(id: Int, completion: @escaping (Bool, String, Int?) -> Void){
        if let token = UserDefaults.standard.string(forKey: "token") {
            DispatchQueue.main.async {
                ApiService.deleteComment(token: token, commentId: id) { error in
                    if let error = error {
                        switch error {
                        case .invalidResponse:
                            completion(false,"Invalid Data", nil)
                        case .noData:
                            completion(false,"No data", nil)
                        case .failed:
                            completion(false,"failed", nil)
                        case .invalidData(let code):
                            completion(false,"invalid data", code)
                        case .invalidStatusCode(let code, let errorContent):
                            completion(false,errorContent, code)
                        }
                        return
                    }
                    completion(true, "Success", nil)
                }
            }
            
        }
    }
    
    func viewComments(id: Int, compeltion: @escaping (Comments?, String, Int?) -> Void) {
        if let token = UserDefaults.standard.string(forKey: "token") {
            ApiService.viewComment(token: token, postId: id) { comments2, error in
                if let error = error {
                    switch error {
                    case .invalidResponse:
                        compeltion(nil,"Invalid Data", nil)
                    case .noData:
                        compeltion(nil,"No data", nil)
                    case .failed:
                        compeltion(nil,"failed", nil)
                    case .invalidData(let code):
                        compeltion(nil,"invalid data", code)
                    case .invalidStatusCode(let code, let errorContent):
                        compeltion(nil,errorContent, code)
                    }
                    return
                }
                self.comments = comments2!
                DispatchQueue.main.async {
                    compeltion(comments2!, "Success", nil)
                }
            }
        }
    }
    
    
    
    
    func numberOfRowsInSection( numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        else{
            return self.comments.count
        }
    }
    
    func cellForRowAt(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCommentTableViewCell", for: indexPath) as? DetailCommentTableViewCell else {return UITableViewCell() }
            
            let date = poster.createdAt
            let index = date.firstIndex(of: "T")!
            cell.userNickName.text = poster.user.username
            cell.contentLabel.text = poster.text
            cell.dateLabel.text = "\(date[..<index])"
            cell.numberOfCommentLabel.text = "댓글 \(poster.comments.count)"
            return cell
        }else{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "DetailPostTableViewCell", for: indexPath) as? DetailPostTableViewCell else {return UITableViewCell() }
            
            
            cell.comment.text = comments[indexPath.row].comment
            cell.nickName.text = comments[indexPath.row].user.username
            return cell
        }
    }
}
