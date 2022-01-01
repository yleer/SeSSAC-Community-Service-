//
//  BoardViewModel.swift
//  2021LastProject
//
//  Created by Yundong Lee on 2021/12/31.
//

import Foundation
import UIKit

class BoardViewModel {
    
    var posters: Poster = []
    
    func getPoster(completion: @escaping () -> Void) {
        if let token = UserDefaults.standard.string(forKey: "token") {
            ApiService.board(token: token) { posters, error in
                if let error = error {
                    print(error)
                    return
                }else{
                    guard let posters = posters else {
                        return
                    }
                    self.posters = posters
                    completion()
                }
            }
        }
    }
    
    
    var numberOfRowsInSection: Int {
        return posters.count
    }
    
    func cellForRowAt(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BoardCell", for: indexPath) as? BoardCell else { return UITableViewCell() }
        
        cell.writer.text = posters[indexPath.row].user.username
        cell.content.text = posters[indexPath.row].text
        cell.date.text = posters[indexPath.row].createdAt
        cell.commentLabel.text = "댓글 \(posters[indexPath.row].comments.count)"
        return cell
    }
    
    func didSelectRowAt(didSelectRowAt indexPath: IndexPath) -> PosterElement {
        return posters[indexPath.row]
    }
        
}
