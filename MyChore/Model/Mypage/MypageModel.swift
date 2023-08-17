//
//  MypageModel.swift
//  MyChore
//
//  Created by 유상 on 2023/08/18.
//

import Foundation

struct UserInfo: Codable {
    let nickname, email, gender, birth: String
    let imgUrl: String?
}
