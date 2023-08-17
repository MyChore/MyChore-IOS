//
//  LoginService.swift
//  MyChore
//
//  Created by 유상 on 2023/08/17.
//

import Foundation
import KakaoSDKUser
import KakaoSDKCommon
import KakaoSDKAuth
import Alamofire

class LoginService {
    
    func loginWithKakao(completion: @escaping (String) -> Void) {
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.loginWithKakaoTalk { (oauthToken, error) in
                if let error = error {
                    print(error)
                }else {
                    _ = oauthToken
                    
                    self.getUserEmailWithKakao(completion: completion)
                }
            }
        }else {
            UserApi.shared.loginWithKakaoAccount { (oauthToken, error) in
                if let error = error {
                    print(error)
                }else {
                    _ = oauthToken
                    
                    self.getUserEmailWithKakao(completion: completion)
                }
            }
        }
    }
    
    
   private func getUserEmailWithKakao(completion: @escaping (String) -> Void) {
        UserApi.shared.me { (user, error) in
            if let error = error {
                print(error)
            }else {
                completion(user?.kakaoAccount?.email ?? "")
            }
        }
    }
    
    func login(parameter: LoginReqModel, completion: @escaping (GeneralResponseModel<LoginRepModel>) -> Void) {
        APIManger.shared.postData(urlEndpointString: "users/login", responseDataType: LoginRepModel.self, requestDataType: LoginReqModel.self, parameter: parameter) { response in
            completion(response)
        }
    }
    
    func checkNickname(nickname: String, completion: @escaping (GeneralResponseModel<Bool>) -> Void) {
        let parameter = ["nickname" : nickname]
        
        APIManger.shared.getData(urlEndpointString: "users/check-nickname", responseDataType: Bool.self, parameter: parameter) { response in
            print(response)
            completion(response)
        }
    }
    
    func join(parameter: JoinReqModel, completion: @escaping (GeneralResponseModel<LoginRepModel>) -> Void) {
        APIManger.shared.postData(urlEndpointString: "users", responseDataType: LoginRepModel.self, requestDataType: JoinReqModel.self, parameter: parameter) { response in
            completion(response)
        }
    }
    
    func getNewToken(completion: @escaping (GeneralResponseModel<String>) -> Void) {
        APIManger.shared.getData(urlEndpointString: "users/token", responseDataType: String.self, parameter: nil) { response in
            completion(response)
        }
    }
}
