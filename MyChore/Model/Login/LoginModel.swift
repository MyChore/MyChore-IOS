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
