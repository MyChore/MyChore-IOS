//
//  InfoCell.swift
//  MyChore
//
//  Created by 유상 on 2023/08/17.
//

import UIKit

class InfoCell: UITableViewCell {

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
    
    func setupTitle(title: String) {
        titleLabel.text = title
    }
    
    func setup() {
        titleLabel.font = .systemFont(ofSize: 17)
        
        nextImageView.image = UIImage(named: "next")
    }
    
    func setupView() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(nextImageView)
    }
    
    func setupConstraint() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(18)
            make.leading.equalToSuperview()
        }
        
        nextImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.trailing.equalToSuperview()

        }
       
    }
    
    override func layoutSubviews() {
      super.layoutSubviews()
      contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 35, bottom: 0, right: 35))
    }

}
