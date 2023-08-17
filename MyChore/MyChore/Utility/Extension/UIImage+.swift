//
//  UIImage+.swift
//  MyChore
//
//  Created by sole on 2023/08/09.
//

import UIKit


extension UIImage {
    /// UIImage의 크기와 색을 변경하는 메서드입니다.
    func setSizeAndColor(width: Double,
                         height: Double,
                         color: UIColor) -> UIImage? {
        let imageSize = CGSize(width: width, height: height)
        return UIGraphicsImageRenderer(size: imageSize).image { _ in
            color.setFill()
            withRenderingMode(.alwaysTemplate)
                .draw(in: .init(origin: .zero,
                                size: imageSize))
        }
    }
}

