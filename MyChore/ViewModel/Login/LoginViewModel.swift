//
//  LoginViewModel.swift
//  MyChore
//
//  Created by 유상 on 2023/08/17.
//

import Foundation
import Combine

class LoginViewModel: ObservableObject {
    static let shared = LoginViewModel()
    private let loginService = LoginService()
    
    private var anyCancelLabels: Set<AnyCancellable> = []
    
    var provider: LoginProvicer?
    
    @Published var userEmail: String?
    @Published var isLogin: Bool?
    @Published var accessToken: String?
    @Published var refreshToken: String?
    
    private var emailAgreeCheck = false
    
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
    
    func setEmailAgreeCheck(check: Bool) {
        self.emailAgreeCheck = check
        print(self.emailAgreeCheck)
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
        loginService.login(userEmail: self.userEmail!, provider: self.provider?.rawValue ?? "") { response in
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
