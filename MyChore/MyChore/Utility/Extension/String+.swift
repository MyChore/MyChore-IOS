//
//  String+.swift
//  MyChore
//
//  Created by 유상 on 2023/08/03.
//

import Foundation

extension String {
    func hasCharacters() -> Bool{
        do{
            let regex = try NSRegularExpression(pattern: "^[a-zA-Z가-힣ㄱ-ㅎㅏ-ㅣ0-9_\\s\\b]$", options: .caseInsensitive)
            if let _ = regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions.reportCompletion, range: NSMakeRange(0, self.count)){
                return true
            }
        }catch{
            print(error.localizedDescription)
            return false
        }
        return false
    }
}
