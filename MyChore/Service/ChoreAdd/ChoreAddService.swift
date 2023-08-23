//
//  ChoreAddService.swift
//  MyChore
//
//  Created by 경유진 on 2023/08/22.
//

import Foundation

class ChoreAddService {
    
    func getGroupInfo(completion: @escaping (GeneralResponseModel<GroupRepModel>) -> Void) {
        print("getGroupInfo")
        APIManger.shared.getData(urlEndpointString: "groups/33", responseDataType: GroupRepModel.self, parameter: nil) { response in
            completion(response)
        }
    }
    
    func addChore(parameter: ChoreReqModel, completion: @escaping (GeneralResponseModel<String>) -> Void) {
        APIManger.shared.postData(urlEndpointString: "chores", responseDataType: String.self, requestDataType: ChoreReqModel.self, parameter: parameter) {
            response in
            completion(response)
        }  
    }
}

