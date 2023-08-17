//
//  LoginViewModel.swift
//  MyChore
//
//  Created by 유상 on 2023/08/17.
//

import Foundation
import Combine
import UIKit

class LoginViewModel: ObservableObject {
    static let shared = LoginViewModel()
    private let loginService = LoginService()
    
    private var anyCancelLabels: Set<AnyCancellable> = []
    
    var provider: LoginProvicer?
    
    @Published var userEmail: String?
    @Published var isLogin: Bool?
    @Published var accessToken: String?
    @Published var refreshToken: String?
    @Published var isJoin: Bool?
    @Published var isOverlap: Bool?
    
    private var emailAgreeCheck = false
    private var profileImage: UIImage?
    private var nickname: String?
    private var gender: String?
    private var birth: String?
    
    
    func getUserEmail(completion: @escaping (String) -> Void) {
        $userEmail.filter { userEmail in
            userEmail != nil
        }.sink { userEmail in
            completion(userEmail!)
        }.store(in: &anyCancelLabels)
    }
    
    func getAccessToken(completion: @escaping (String) -> Void) {
        $accessToken.filter { accessToken in
            accessToken != nil
        }.sink { accessToken in
            completion(accessToken!)
        }.store(in: &anyCancelLabels)
    }
    
    func getIsJoin(completion: @escaping (Bool) -> Void) {
        $isJoin.filter { isJoin in
            isJoin != nil
        }.sink { isJoin in
            completion(isJoin!)
        }.store(in: &anyCancelLabels)
    }
    
    func getIsOverlap(completion: @escaping (Bool) -> Void) {
        $isOverlap.filter { isOverlap in
            isOverlap != nil
        }.sink { isOverlap in
            completion(isOverlap!)
        }.store(in: &anyCancelLabels)
    }
    
    func setEmailAgreeCheck(check: Bool) {
        self.emailAgreeCheck = check
        print(self.emailAgreeCheck)
    }
    
    func setProfileImage(image: UIImage) {
        self.profileImage = image
    }
    
    func setNickname(nickname: String) {
        self.nickname = nickname
    }
    
    func setGender(gender: String) {
        self.gender = gender
    }
    
    func setBirth(birth: String) {
        self.birth = birth
        print(self.birth)
    }
    
    
}


extension LoginViewModel {
    func loginWithKakao() {
        loginService.loginWithKakao { email in
            self.userEmail = email
            self.provider = .KAKAO
            
            self.login()
        }
    }
    
    func login() {
        let parameter = LoginReqModel(email: userEmail!, provider: provider?.rawValue ?? "")
        
        loginService.login(parameter: parameter) { response in
            if response.statusCode == 200 {
                if let data = response.data {
                    self.accessToken = data.accessToken
                    self.refreshToken = data.refreshToken
                    self.isJoin = true
                }
            }else {
                self.accessToken = ""
                self.refreshToken = ""
                self.isJoin = false
            }
        }
    }
    
    func checkNickname(nickname: String) {
        print("닉네임: " + nickname)
        loginService.checkNickname(nickname: nickname) { response in
            print(nickname + "의 결과: \(response)")
            if response.statusCode == 200 {
                if let result = response.data {
                    self.isOverlap = result
                }
            }
        }
    }
    
    
    func join() {
        let parameter = JoinReqModel(email: userEmail!, birth: birth!, gender: gender!, nickname: nickname!, provider: provider?.rawValue ?? "", imgUrl: nil, is14Over: true, isAcceptEmail: emailAgreeCheck)
        
        loginService.join(parameter: parameter) { response in
            if response.statusCode == 200 {
                if let data = response.data {
                    self.accessToken = data.accessToken
                    self.refreshToken = data.refreshToken
                }
            }else {
                self.accessToken = ""
                self.refreshToken = ""
            }
        }
    }
}
