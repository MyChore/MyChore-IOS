//
//  MyPageCell.swift
//  MyChore
//
//  Created by 유상 on 2023/08/16.
//

import UIKit
import SnapKit

class MyPageCell: UITableViewCell {
    
    private let titleImageView = UIImageView()
    private let titleLabel = UILabel()
    private let nextImageView = UIImageView()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
        setupView()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupTitle(title: String, image: String) {
        titleLabel.text = title
        titleImageView.image = UIImage(named: image)
    }
    
    func setup() {
        titleLabel.font = .systemFont(ofSize: 17)
        
        nextImageView.image = UIImage(named: "next")
    }
    
    func setupView() {
        contentView.addSubview(titleImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(nextImageView)
    }
    
    func setupConstraint() {
//        contentView.snp.makeConstraints { make in
//            make.height.equalTo(50)
//        }
        
        
        titleImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(13)
            make.leading.equalToSuperview()
            make.height.equalTo(30)
            make.width.equalTo(30)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleImageView.snp.trailing).offset(12)
            make.centerY.equalTo(titleImageView.snp.centerY)
        }
        
        nextImageView.snp.makeConstraints { make in
            make.centerY.equalTo(titleImageView.snp.centerY)
            make.trailing.equalToSuperview()

        }
       
    }
    
    override func layoutSubviews() {
      super.layoutSubviews()
      contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 35, bottom: 0, right: 35))
    }
}
