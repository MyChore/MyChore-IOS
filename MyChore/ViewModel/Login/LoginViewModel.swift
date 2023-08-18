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
    
    @Published var accessToken: String?
    @Published var refreshToken: String?
    
    @Published var userEmail: String?
    @Published var isLogin: Bool?
    @Published var isJoin: Bool?
    @Published var isOverlap: Bool?
    @Published var isLoadToken: Bool?
    
    private var emailAgreeCheck = false
    private var profileImage: UIImage?
    private var nickname: String?
    private var gender: String?
    private var birth: String?
    private var imageUrl: String?
    
    
    func getUserEmail(completion: @escaping (String) -> Void) {
        $userEmail.filter { userEmail in
            userEmail != nil
        }.sink { userEmail in
            completion(userEmail!)
        }.store(in: &anyCancelLabels)
    }
    
    func getAccessToken(completion: @escaping (String) -> Void) {
        $accessToken.sink { accessToken in
            completion(accessToken ?? "")
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
    
    func getIsLoadToken(completion: @escaping (Bool) -> Void) {
        $isLoadToken.filter { isLoadToken in
            isLoadToken != nil
        }.sink { isLoadToken in
            completion(isLoadToken!)
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
    }
    
}


extension LoginViewModel {
    func saveToken() {
        let token = LoginRepModel(accessToken: self.accessToken!, refreshToken: self.refreshToken!)
        
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(token) {
           UserDefaults.standard.setValue(encoded, forKey: "UserToken")
        }
    }
    
    func loadToken() {
        if UserDefaults.standard.value(forKey: "UserToken") != nil {
            if let userTokenData = UserDefaults.standard.object(forKey: "UserToken") as? Data {
                let decoder = JSONDecoder()
                if let userToken = try? decoder.decode(LoginRepModel.self, from: userTokenData) {
                    self.accessToken = userToken.accessToken
                    self.refreshToken = userToken.refreshToken
                }
            }
        }
    }
    
    func getNewToken() {
        if let refreshToken = refreshToken {
            APIManger.shared.setRefreshToken(refreshToken: refreshToken)
        }
        
        loginService.getNewToken { response in
            if response.statusCode == 200 {
                if let newToken = response.data {
                    self.accessToken = newToken
                    self.saveToken()
                }
            }
        }
    }
    
    
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
                    self.saveToken()
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
        loginService.checkNickname(nickname: nickname) { response in
            if response.statusCode == 200 {
                if let result = response.data {
                    self.isOverlap = result
                }
            }
        }
    }
    
    func uploadImage() {
        guard let image = profileImage else {return}
        

        
        FirebaseStorageManager.shared.uploadImage(image: image) { imageUrl in
            if let imageUrl = imageUrl {
                self.imageUrl = imageUrl.description
                print(imageUrl)
            }
        }
    }
    
    
    func join() {
        let parameter = JoinReqModel(email: userEmail!, birth: birth!, gender: gender!, nickname: nickname!, provider: provider?.rawValue ?? "", imgUrl: imageUrl, is14Over: true, isAcceptEmail: emailAgreeCheck)
        
        loginService.join(parameter: parameter) { response in
            if response.statusCode == 200 {
                if let data = response.data {
                    self.accessToken = data.accessToken
                    self.refreshToken = data.refreshToken
                    self.saveToken()
                }
            }else {
                self.accessToken = ""
                self.refreshToken = ""
            }
        }
    }
    
    func logout() {
        print("123")
        
        provider = nil
        
        accessToken = ""
        refreshToken = ""
        
        userEmail = nil
        isLogin = nil
        isJoin = nil
        isOverlap = nil
        isLoadToken = nil
        
        emailAgreeCheck = false
        profileImage = nil
        nickname = nil
        gender = nil
        birth = nil
        imageUrl = nil
        UserDefaults.standard.removeObject(forKey: "UserToken")
    }
}
