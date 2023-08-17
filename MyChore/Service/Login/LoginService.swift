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
    
    
    
    
    
    func login(userEmail: String, provider: String, completion: @escaping (GeneralResponseModel<LoginRepModel>) -> Void) {
        let parameter = LoginReqModel(email: userEmail, provider: provider)
        
        APIManger.shared.postData(urlEndpointString: "users/login", responseDataType: LoginRepModel.self, requestDataType: LoginReqModel.self, parameter: parameter) { response in
            completion(response)
        }
    }
}
