//
//  FloorModel.swift
//  MyChore
//
//  Created by 유상 on 2023/08/22.
//

import Foundation

struct AddFloorReqModel: Codable {
    let floorName: String
    let floorType: Double
    let rooms: [Rooms]?
}

struct Rooms: Codable {
    let sizeX, sizeY, locationX, locationY: Int
    let roomTypeName, name: String
}

struct AddFloorRepModel: Codable {
    let groupId, groupUserId: Int
    let inviteCode: String
    let roomIdList: [Int]?
}
