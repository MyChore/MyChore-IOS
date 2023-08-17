//
//  MypageViewModel.swift
//  MyChore
//
//  Created by 유상 on 2023/08/18.
//

import Foundation
import Combine

class MypageViewModel: ObservableObject {
    static let shared = MypageViewModel()
    private let mypageService = MypageService()
    
    private var anyCancelLabels: Set<AnyCancellable> = []
    
    @Published var userInfo: UserInfo?
    
    func getUserInfo(completion: @escaping (UserInfo) -> Void) {
        $userInfo.filter { userInfo in
            userInfo != nil
        }.sink { userInfo in
            completion(userInfo!)
        }.store(in: &anyCancelLabels)
    }
}


extension MypageViewModel {
    func requestMyprofile() {
        mypageService.requestMyprofile { response in
            if response.statusCode == 200 {
                if let data = response.data {
                    self.userInfo = data
                }
            }else if response.statusCode == 403 {
                
                LoginViewModel.shared.getNewToken()
            }
        }
    }
}
