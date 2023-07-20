//
//  Color+.swift
//  MyChore
//
//  Created by sole on 2023/07/20.
//

import UIKit

extension UIColor {
    convenience init(hex: Int, alpha: Double = 1.0) {
        let red = Double((hex >> 16) & 0xff) / 255
        let green = Double((hex >> 8) & 0xff) / 255
        let blue = Double((hex >> 0) & 0xff) / 255
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    convenience init(hex: String, alpha: Double = 1.0) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")
        
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        
        let r = Double((rgb >> 16) & 0xFF) / 255.0
        let g = Double((rgb >>  8) & 0xFF) / 255.0
        let b = Double((rgb >>  0) & 0xFF) / 255.0
        self.init(red: r, green: g, blue: b, alpha: 1.0)
    }
    
    static let mcMainGreen = UIColor(hex: "#3ABB81")
    
    static let mcSubGreen400 = UIColor(hex: "#36AE78")
    static let mcSubGreen300 = UIColor(hex: "#61C99A")
    static let mcSubGreen200 = UIColor(hex: "#86CEAE")
    static let mcSubGreen100 = UIColor(hex: "#EBF7F2")
    
    static let mcGrey800 = UIColor(hex: "#090909")
    static let mcGrey700 = UIColor(hex: "#414141")
    static let mcGrey600 = UIColor(hex: "#707070")
    static let mcGrey500 = UIColor(hex: "#BCBCBC")
    static let mcGrey400 = UIColor(hex: "#CACACA")
    static let mcGrey300 = UIColor(hex: "#D9D9D9")
    static let mcGrey200 = UIColor(hex: "#EFEFEF")
    static let mcGrey100 = UIColor(hex: "#F4F5F5")
}

