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
    
    func writeComment(comment: String, id: Int) {
        if let token = UserDefaults.standard.string(forKey: "token") {
            ApiService.writeComment(token: token, comment: comment, postId: id) { error in
                if let error = error {
                    print("comment not created", error)
                    return
                }
                print("comment created")
            }
        }
    }
    
    func deletePost(id: Int, completion: @escaping () -> Void){
        if let token = UserDefaults.standard.string(forKey: "token") {
            ApiService.deletePost(token: token, postId: id) { error in
                if let error = error {
                    print("comment not created", error)
                    return
                }
                DispatchQueue.main.async {
                    completion()
                }
            }
        }
    }
    
    func numberOfRowsInSection( numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        else{
            return poster.comments.count
        }
    }
    
    func cellForRowAt(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCommentTableViewCell", for: indexPath) as? DetailCommentTableViewCell else {return UITableViewCell() }
            cell.userNickName.text = poster.user.username
            cell.contentLabel.text = poster.text
            cell.dateLabel.text = poster.createdAt
            cell.numberOfCommentLabel.text = "댓글 \(poster.comments.count)"
            return cell
        }else{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "DetailPostTableViewCell", for: indexPath) as? DetailPostTableViewCell else {return UITableViewCell() }
            
            cell.comment.text = poster.comments[indexPath.row].comment
            cell.nickName.text = "\(poster.comments[indexPath.row].user)"
         
            return cell
        }
    }
    
    
    
    

}
