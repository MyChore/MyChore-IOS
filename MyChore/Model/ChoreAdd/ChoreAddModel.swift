//
//  ChoreAddModel.swift
//  MyChore
//
//  Created by 경유진 on 2023/08/22.
//

import Foundation

struct GroupRepModel: Codable {
    let groupName, floorTypeName: String
    let memberList: [MemberList]
    let roomList: [RoomList]
}

struct MemberList: Codable {
    let nickname: String
    let imgUrl: String?
}

struct RoomList: Codable {
    let roomTypeName: String
    let furnitureList: [FurnitureList]
}

struct FurnitureList: Codable {
    let furnitureName: String
}

struct ChoreReqModel: Codable {
    let userId, groupId, roomFurnitureId: Int
    let name, notiTime: String
    let repetition: String?
    let isAcceptNoti: Bool
    let startDate: Date
    let lastDate: Date?
}

