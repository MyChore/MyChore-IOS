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
    
    func getUserEmail(completion: @escaping (String) -> Void) {
        $userEmail.filter { userEmail in
            userEmail != nil
        }.sink { userEmail in
            completion(userEmail!)
        }.store(in: &anyCancelLabels)
    }
    
}


extension LoginViewModel {
    func loginWithKakao() {
        loginService.loginWithKakao { email in
            self.userEmail = email
        }
    }
    
    func login() {
        
    }
}
