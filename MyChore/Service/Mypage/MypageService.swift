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
    
    func checkNickname(nickname: String, completion: @escaping (GeneralResponseModel<Bool>) -> Void) {
        let parameter = ["nickname" : nickname]
        
        APIManger.shared.getData(urlEndpointString: "users/check-nickname", responseDataType: Bool.self, parameter: parameter) { response in
            completion(response)
        }
    }
    
    func changeProfileImage(imgUrl: String, completion: @escaping (GeneralResponseModel<Bool>) -> Void) {
        let parameter = ChangeImgReqModel(imgUrl: imgUrl)
        
        APIManger.shared.patchData(urlEndpointString: "users/profileimg", responseDataType: Bool.self, requestDataType: ChangeImgReqModel.self, parameter: parameter) { response in
            completion(response)
        }
    }
    
    func changeMyInfo(parameter: ChangeUserReqModel, completion: @escaping (GeneralResponseModel<Bool>) -> Void) {
        APIManger.shared.patchData(urlEndpointString: "users", responseDataType: Bool.self, requestDataType: ChangeUserReqModel.self, parameter: parameter) { response in
            print(response)
            completion(response)
        }
    }
}
