//
//  MypageViewModel.swift
//  MyChore
//
//  Created by 유상 on 2023/08/18.
//

import Foundation
import Combine
import UIKit

class MypageViewModel: ObservableObject {
    static let shared = MypageViewModel()
    private let mypageService = MypageService()
    
    private var anyCancelLabels: Set<AnyCancellable> = []
    
    @Published var userInfo: UserInfo?
    @Published var isOverlap: Bool?
    @Published var isSameNickname = true
    @Published var isChangeMyInfo: Bool?
    
    private var profileImage: UIImage?
    private var isImage = false
    private var isChangeNickname = false
    private var isChangeImage = false
    private var isChangeGender = false
    private var isChangeYear = false
    private var isChangeMonth = false
    private var isChangeDay = false
    
    var _isImage: Bool {
        get {
            return isImage
        }
        set(result) {
            isImage = result
        }
    }
    
    
    var _isChangeNickname: Bool {
        get {
            return isChangeNickname
        }
        set(result) {
            isChangeNickname = result
        }
    }
    
    var _isChangeImage: Bool {
        get {
            return isChangeImage
        }
        set(result) {
            isChangeImage = result
        }
    }
    
    var _isChangeGender: Bool {
        get {
            return isChangeGender
        }
        set(result) {
            isChangeGender = result
        }
    }
    
    var _isChangeYear: Bool {
        get {
            return isChangeYear
        }
        set(result) {
            isChangeYear = result
        }
    }
    
    var _isChangeMonth: Bool {
        get {
            return isChangeMonth
        }
        set(result) {
            isChangeMonth = result
        }
    }
    
    var _isChangeDay: Bool {
        get {
            return isChangeDay
        }
        set(result) {
            isChangeDay = result
        }
    }
    
    func getUserInfo(completion: @escaping (UserInfo) -> Void) {
        $userInfo.filter { userInfo in
            userInfo != nil
        }.sink { userInfo in
            completion(userInfo!)
        }.store(in: &anyCancelLabels)
    }
    
    func getIsOverlap(completion: @escaping (Bool) -> Void) {
        $isOverlap.filter { isOverlap in
            isOverlap != nil
        }.sink { isOverlap in
            completion(isOverlap!)
        }.store(in: &anyCancelLabels)
    }
    
    func getIsSameNickname(completion: @escaping (Bool) -> Void) {
        $isSameNickname.sink { isSameNickname in
            completion(isSameNickname)
        }.store(in: &anyCancelLabels)
    }
    
    func getIsChangeMyInfo(completion: @escaping (Bool) -> Void) {
        $isChangeMyInfo.filter { isChangeMyInfo in
            isChangeMyInfo != nil
        }.sink { isChangeMyInfo in
            completion(isChangeMyInfo!)
        }.store(in: &anyCancelLabels)
    }
    
    func setProfileImage(image: UIImage) {
        profileImage = image
    }
    
    
   
}


extension MypageViewModel {
    func requestMyprofile() {
        mypageService.requestMyprofile { response in
            if response.statusCode == 200 {
                if let data = response.data {
                    self.userInfo = data
                    
                    if let imageUrl = data.imgUrl {
                        self.isImage = true
                    }
                }
            }else if response.statusCode == 403 {
                LoginViewModel.shared.getNewToken()
                self.requestMyprofile()
            }
        }
    }
    
    func doneChnageMyprofile() {
        isOverlap = nil
        isSameNickname = true
        isChangeMyInfo = false
        
        profileImage = nil
        isImage = false
        isChangeNickname = false
        isChangeImage = false
        isChangeGender = false
        isChangeYear = false
        isChangeMonth = false
        isChangeDay = false
    }
    
    
    func checkNickname(nickname: String) {
        if nickname == userInfo?.nickname {
            isSameNickname = true
            self.isChangeNickname = false
            isOverlap = nil
            return
        }
        
        mypageService.checkNickname(nickname: nickname) { response in
            if response.statusCode == 200 {
                if let result = response.data {
                    self.isChangeNickname = true
                    self.isSameNickname = false
                    self.isOverlap = result
                }
            }
        }
    }
    
    func changeMyInfo(nickname: String, gender: String, birth: String) {
        if let image = profileImage {
            FirebaseStorageManager.shared.uploadImage(image: image) { [self] imgUrl in
                if let url = imgUrl?.description {
                    mypageService.changeProfileImage(imgUrl: url) { [self] response in
                        if response.statusCode == 200 {
                            if isChangeNickname || isChangeGender || isChangeYear || isChangeMonth || isChangeDay {
                                changeMyInfo(parameter: ChangeUserReqModel(nickname: nickname, gender: gender, birth: birth))
                            }else {
                                self.isChangeMyInfo = true
                            }
                        }
                    }
                }
            }
        }else {
            if isChangeNickname || isChangeGender || isChangeYear || isChangeMonth || isChangeDay {
                let parameter = ChangeUserReqModel(nickname: nickname, gender: gender, birth: birth)
                changeMyInfo(parameter: parameter)
            }
        }
        
       
    }
    
    func changeMyInfo(parameter: ChangeUserReqModel) {
        mypageService.changeMyInfo(parameter: parameter) { response in
            if response.statusCode == 200 {
                self.isChangeMyInfo = true
            }
        }
    }
    
    
    
    func checkYear(year: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let userInfo = userInfo {
            let date = dateFormatter.date(from: userInfo.birth)
            let calendar = Calendar.current
            let components = calendar.dateComponents([.year, .month, .day], from: date!)
            
            if year != components.year?.description {
                isChangeYear = true
            }else {
                isChangeYear = false
            }
        }
    }
    
    func checkMonth(month: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let userInfo = userInfo {
            let date = dateFormatter.date(from: userInfo.birth)
            let calendar = Calendar.current
            let components = calendar.dateComponents([.year, .month, .day], from: date!)
            
            if month != components.month?.description {
                isChangeMonth = true
            }else {
                isChangeMonth = false
            }
        }
    }

    func checkDay(day: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let userInfo = userInfo {
            let date = dateFormatter.date(from: userInfo.birth)
            let calendar = Calendar.current
            let components = calendar.dateComponents([.year, .month, .day], from: date!)
            
            if day != components.day?.description {
                isChangeDay = true
            }else {
                isChangeDay = false
            }
        }
    }
    
    func checkGender(gender: String) {
        if let userInfo = userInfo {
            if gender == userInfo.gender {
                isChangeGender = false
            }else {
                isChangeGender = true
            }
        }
    }
    
    func checkChangeMyInfo() -> Bool {
        if let image = profileImage {
            return true
        }else {
            return isChangeNickname || isChangeGender || isChangeYear || isChangeMonth || isChangeDay
        }
    }

    
}
