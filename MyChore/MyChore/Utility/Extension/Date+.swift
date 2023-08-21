//
//  Date+.swift
//  MyChore
//
//  Created by sole on 2023/08/20.
//

import Foundation

extension Date {
    func formatUntilDay() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd."
        dateFormatter.locale = Locale(identifier: "ko_KR")
        
        return dateFormatter.string(from: self)
    }
}
