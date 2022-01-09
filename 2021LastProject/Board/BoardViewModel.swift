//
//  BoardViewModel.swift
//  2021LastProject
//
//  Created by Yundong Lee on 2021/12/31.
//

import Foundation
import UIKit

class BoardViewModel {
    
    var posters: Poster = []{
        didSet{
            print(posters.count)
        }
    }
    
    func getPoster(start: Int,limit: Int, refresh: Bool = false , completion: @escaping (String?, Int?) -> Void) {

        if let token = UserDefaults.standard.string(forKey: "token") {
            ApiService.board(token: token,start: start, limit: limit) { posters, error in
                if let error = error {
                    switch error {
                    case .invalidResponse:
                        completion("Invalid Response", nil)
                    case .noData:
                        completion("No data", nil)
                    case .failed:
                        completion("Failed", nil)
                    case .invalidData(let code):
                        completion("Invalid Data", code)
                    case .invalidStatusCode(let code, let errorContent):
                        completion(errorContent, code)
                    }
                    return
                }else{
                    guard let posters = posters else {
                        return
                    }
                    
                    if refresh {
                        self.posters = posters
                    }else {
                        self.posters += posters
                    }
                    
                    completion(nil, nil)
                }
            }
        }
    }
    
    
    var numberOfRowsInSection: Int {
        return posters.count
    }
    
    func cellForRowAt(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BoardCell", for: indexPath) as? BoardCell else { return UITableViewCell()
        }
        
//        let date = posters[indexPath.row].createdAt
//        let index = date.firstIndex(of: "T")!
        cell.writer.text = posters[indexPath.row].user.username
        cell.content.text = posters[indexPath.row].text
//        cell.date.text = "\(date[..<index])"
        cell.commentLabel.text = "댓글 \(posters[indexPath.row].comments.count)"
        return cell
    }
    
    func didSelectRowAt(didSelectRowAt indexPath: IndexPath) -> PosterElement {
        return posters[indexPath.row]
    }
}
