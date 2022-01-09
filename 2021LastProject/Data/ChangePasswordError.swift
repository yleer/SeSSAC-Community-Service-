//
//  ErrorData.swift
//  2021LastProject
//
//  Created by Yundong Lee on 2022/01/09.
//

import Foundation

struct ChangePasswordError: Codable {
    let statusCode: Int
    let error, message: String
}

struct LoginError: Codable {
    let statusCode: Int
    let error: String
    let message, data: [Datum]
}

// MARK: - Datum
struct Datum: Codable {
    let messages: [Message]
}

// MARK: - Message
struct Message: Codable {
    let id, message: String
}

