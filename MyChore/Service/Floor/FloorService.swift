//
//  FloorService.swift
//  MyChore
//
//  Created by 유상 on 2023/08/22.
//

import Foundation

class FloorService {
    func addFloor(parameter: AddFloorReqModel, completion: @escaping (GeneralResponseModel<AddFloorRepModel>) -> Void) {
        APIManger.shared.postData(urlEndpointString: "groups", responseDataType: AddFloorRepModel.self, requestDataType: AddFloorReqModel.self, parameter: parameter) { response in
            print(response)
            completion(response)
        }
    }
}
