//
//  MypageService.swift
//  MyChore
//
//  Created by 유상 on 2023/08/18.
//

import Foundation

class MypageService {
    func requestMyprofile(completion: @escaping (GeneralResponseModel<UserInfo>) -> Void) {
        APIManger.shared.getData(urlEndpointString: "users", responseDataType: UserInfo.self, parameter: nil) { response in
            completion(response)
        }
    }
}
