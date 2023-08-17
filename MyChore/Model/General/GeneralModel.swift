//
//  GeneralModel.swift
//  MyChore
//
//  Created by 유상 on 2023/08/17.
//

import Foundation

struct GeneralResponseModel<T: Codable>: Codable {
    let data: T?
    let status, message: String?
    let statusCode: Int?
}


struct GeneralResponseListModel<T: Codable>: Codable {
    let data: [T]?
    let status, message: String?
    let statusCode: Int?
}
