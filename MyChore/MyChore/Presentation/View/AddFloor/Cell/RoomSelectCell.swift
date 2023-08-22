//
//  RoomSelectCell.swift
//  MyChore
//
//  Created by 유상 on 2023/08/22.
//

import UIKit
import SnapKit

enum RoomKind: String, CaseIterable {
    case one = "원룸"
    case separation = "분리형 원룸"
    case two = "투룸"
    case three = "쓰리룸"
}

extension RoomKind {
    func getRoomComposition() -> String {
        switch self {
        case .one:
            return "거실\n화장실 1개"
        case .separation:
            return "거실\n방 1개\n화장실 1개"
        case .two:
            return "거실\n방 2개\n화장실 1개"
        case .three:
            return "거실\n방 3개\n화장실 2개"
        }
    }
    
    func getRoomImage() -> String {
        switch self {
        case .one:
            return "oneroom"
        case .separation:
            return "separationroom"
        case .two:
            return "tworoom"
        case .three:
            return "threeroom"
        }
    }
    
    func getRoomSelectedImage() -> String {
        switch self {
        case .one:
            return "oneroom_selected"
        case .separation:
            return "separationroom_selected"
        case .two:
            return "tworoom_selected"
        case .three:
            return "threeroom_selected"
        }
    }
}

class RoomSelectCell: UICollectionViewCell {
    let titleLabel = UILabel()
    let contentLabel = UILabel()
    
    let contentImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        setupCell()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        self.contentView.backgroundColor = .mcGrey100
        self.contentView.layer.cornerRadius = 10
        
        titleLabel.font = .systemFont(ofSize: 20)
        
        contentLabel.numberOfLines = 0
        contentLabel.font = .systemFont(ofSize: 12)
        contentLabel.textColor = .mcGrey600
    }
    
    func setupCell() {
        addSubview(titleLabel)
        addSubview(contentLabel)
        addSubview(contentImageView)
    }
    
    func setupConstraint() {
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(18)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)
        }
        
        contentImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-12)
            make.bottom.equalToSuperview().offset(-14)
            make.width.equalTo(self.contentView.snp.width).dividedBy(2.3)
            make.height.equalTo(self.contentView.snp.height).dividedBy(2.1)
        }
    }
}
