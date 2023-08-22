//
//  FloorViewModel.swift
//  MyChore
//
//  Created by 유상 on 2023/08/22.
//

import Foundation
import Combine

class FloorViewModel: ObservableObject {
    static let shared = FloorViewModel()
    private let floorService = FloorService()
    
    private var cancelLabels: Set<AnyCancellable> = []
    
    private var floorType: Double = 0
    private var floorName: String = ""
    
    @Published var inviteCode: String?
    
    var _floorName: String {
        get {
            return floorName
        }
        set(floorName) {
            self.floorName = floorName
        }
    }
   
    func getInviteCode(completion: @escaping (String) -> Void) {
        $inviteCode.filter { inviteCode in
            inviteCode != nil
        }.sink { inviteCode in
            completion(inviteCode!)
        }.store(in: &cancelLabels)
    }
    
    func setFloorType(roomKind: RoomKind) {
        switch roomKind {
        case .one:
            floorType = 1
        case .separation:
            floorType = 1.5
        case .two:
            floorType = 2
        case .three:
            floorType = 3
        }
    }
}

extension FloorViewModel {
    func addFloor() {
        let parameter = AddFloorReqModel(floorName: floorName, floorType: floorType, rooms: nil)
        
        floorService.addFloor(parameter: parameter) { response in
            if response.statusCode == 200 {
                if let data = response.data {
                    self.inviteCode = data.inviteCode
                }
            }
        }
    }
}
