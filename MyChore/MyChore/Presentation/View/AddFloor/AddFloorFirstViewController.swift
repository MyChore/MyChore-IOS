//
//  AddFloorFirstViewController.swift
//  MyChore
//
//  Created by 유상 on 2023/08/21.
//

import UIKit
import SnapKit

class AddFloorFirstViewController: UIViewController {
    
    private let titleLabel = UILabel()
    private let contentLabel = UILabel()
    
    private let contentImageView = UIImageView()
    
    private let nextButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setupView()
        setupConstraint()
    }
    
    private func setup() {
        
        titleLabel.text = "평면도도 내게 맞춰서,"
        titleLabel.font = .systemFont(ofSize: 28)
        
        contentLabel.text = "우리집에 꼭 맞는 평면도를\n만들어 봐요!"
        contentLabel.numberOfLines = 0
        contentLabel.font = .systemFont(ofSize: 18)
        contentLabel.textColor = .mcGrey600
        
        contentImageView.image = UIImage(named: "floorAddImage")
        
        nextButton.setTitle("다음", for: .normal)
        nextButton.backgroundColor = .mcMainGreen
        nextButton.tintColor = .white
        nextButton.layer.cornerRadius = 10
        
    }
    
    private func setupView() {
        self.view.backgroundColor = .white
        
        self.view.addSubview(titleLabel)
        self.view.addSubview(contentLabel)
        self.view.addSubview(contentImageView)
        self.view.addSubview(nextButton)
    }
    
    private func setupConstraint() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(67)
            make.leading.equalToSuperview().offset(24)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(24)
        }
        
        contentImageView.snp.makeConstraints { make in
            make.top.equalTo(contentLabel.snp.bottom).offset(8)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).inset(8)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview()
        }
        
        nextButton.snp.makeConstraints { make in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).inset(8)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(58)
        }
    }
    
    @objc private func backNavigationAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func nextButtonAction() {
        
    }

}
