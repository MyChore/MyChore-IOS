//
//  LoginModel.swift
//  MyChore
//
//  Created by 유상 on 2023/08/17.
//

import Foundation

struct LoginReqModel: Codable {
    let email, provider: String
}

struct LoginRepModel: Codable {
    let accessToken, refreshToken: String
}

struct JoinReqModel: Codable {
    let email, birth, gender, nickname, provider : String
    let imgUrl: String?
    let is14Over, isAcceptEmail: Bool
}
