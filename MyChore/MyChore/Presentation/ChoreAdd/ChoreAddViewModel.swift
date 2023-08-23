//
//  ChoreAddViewModel.swift
//  MyChore
//
//  Created by 경유진 on 2023/08/22.
//

import Foundation

class ChoreAddViewModel {
    
    static let shared = ChoreAddViewModel()
    private let choreAddService = ChoreAddService()
    var groupInfoList: GroupRepModel?
    var member: [MemberList] = []
    var room: [RoomList] = []
    var furniture: [FurnitureList] = []
    
    var userId, groupId, roomFurnitureId: Int!
    var name, notiTime: String!
    var repetition: String?
    var isAcceptNoti: Bool!
    var startDate: Date!
    var lastDate: Date?
    
    func getGroupInfo() {
        choreAddService.getGroupInfo { response in
            if response.statusCode == 200 {
                if let data = response.data {
                    self.groupInfoList = data
                    self.member = data.memberList
                    self.room = data.roomList
                    print(self.groupInfoList)
                    print(self.member)
                    print(self.room)
                }
            }
            else if response.statusCode == 403 {
                LoginViewModel.shared.getNewToken()
                self.getGroupInfo()
            }
        }
    }
    
    func addChore() {
        let parameter = ChoreReqModel(userId: userId, groupId: groupId, roomFurnitureId: roomFurnitureId, name: name, notiTime: notiTime, repetition: repetition, isAcceptNoti: isAcceptNoti, startDate: startDate, lastDate: lastDate)
        
        choreAddService.addChore(parameter: parameter) { response in
            if response.statusCode == 200 {
                print("성공")
            }
        }
    }
}

