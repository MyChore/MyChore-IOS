//
//  Tag.swift
//  MyChore
//
//  Created by sole on 2023/08/18.
//

import UIKit

//MARK: - makeTag
/// 태그를 생성하는 메서드입니다.
func makeTag(tagName: String?) -> UIView {
    guard let tagName else { return UIView() }
    let ellipse = UIView()
    ellipse.layer.cornerRadius = 12
    ellipse.backgroundColor = .mcMainGreen
    
    let spaceLabel = UILabel()
    spaceLabel.text = tagName
    spaceLabel.textColor = .white
    spaceLabel.font = UIFont.systemFont(ofSize: 15,
                                        weight: .medium)
    
    ellipse.addSubview(spaceLabel)
    
    ellipse.snp.makeConstraints {
        $0.width.lessThanOrEqualTo(50)
        $0.height.lessThanOrEqualTo(28)
    }
    
    spaceLabel.snp.makeConstraints {
        $0.center.equalToSuperview()
    }
    
    return ellipse
}

