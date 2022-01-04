//
//  Comments.swift
//  2021LastProject
//
//  Created by Yundong Lee on 2022/01/04.
//

import Foundation
// MARK: - Comment
struct Comment2: Codable {
    let id: Int
    let comment: String
    let user: User3
    let post: Post
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, comment, user, post
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}



// MARK: - Post
struct Post: Codable {
    let id: Int
    let text: String
    let user: Int
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, text, user
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

// MARK: - User
//struct User3: Codable {
//    let id: Int
//    let username, email, provider: String
//    let confirmed: Bool
////    let blocked: JSONNull?
//    let role: Int
//    let createdAt, updatedAt: String
//
//    enum CodingKeys: String, CodingKey {
//        case id, username, email, provider, confirmed, blocked, role
//        case createdAt = "created_at"
//        case updatedAt = "updated_at"
//    }
//}
struct User3: Codable {
    let id: Int
    let username, email, provider: String
    let confirmed: Bool
    let blocked: Bool?
    let role: Int
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, username, email, provider, confirmed, blocked, role
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}


typealias Comments = [Comment2]

// MARK: - Encode/decode helpers

//class JSONNull: Codable, Hashable {
//
//    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
//        return true
//    }
//
//    public var hashValue: Int {
//        return 0
//    }
//
//    public init() {}
//
//    public required init(from decoder: Decoder) throws {
//        let container = try decoder.singleValueContainer()
//        if !container.decodeNil() {
//            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
//        }
//    }
//
//    public func encode(to encoder: Encoder) throws {
//        var container = encoder.singleValueContainer()
//        try container.encodeNil()
//    }
//}
