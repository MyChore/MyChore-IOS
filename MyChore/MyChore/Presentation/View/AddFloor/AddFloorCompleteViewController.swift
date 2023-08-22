//
//  AddFloorCompleteViewController.swift
//  MyChore
//
//  Created by 유상 on 2023/08/22.
//

import UIKit
import SnapKit

class AddFloorCompleteViewController: UIViewController {
    
    private let titleLabel = UILabel()
    private let contentLabel = UILabel()
    
    private let teamCodeLabel = UILabel()
    private let teamCodeCopyButton = UIButton()
    
    private let nextButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setupView()
        setupConstraint()
        setupObserver()
    }
    
    private func setup() {
        self.navigationController?.navigationBar.isHidden = true
        
        titleLabel.text = "마쵸 사랑해 평면도가\n생성되었어요!"
        titleLabel.numberOfLines = 0
        titleLabel.font = .systemFont(ofSize: 28)
        
        contentLabel.text = "동료에게 코드를 공유해봐요!"
        contentLabel.font = .systemFont(ofSize: 18)
        contentLabel.textColor = .mcGrey600
        
        teamCodeLabel.text = "코드"
        teamCodeLabel.font = .systemFont(ofSize: 18)
        teamCodeLabel.textColor = .mcGrey600
        
        teamCodeCopyButton.setImage(UIImage(named: "copy_button"), for: .normal)
        teamCodeCopyButton.addTarget(self, action: #selector(copyButtonAction), for: .touchDown)
        
        nextButton.setTitle("다음", for: .normal)
        nextButton.backgroundColor = .mcMainGreen
        nextButton.tintColor = .white
        nextButton.layer.cornerRadius = 10
        nextButton.addTarget(self, action: #selector(nextButtonAction), for: .touchDown)
        
    }
    
    private func setupView() {
        self.view.backgroundColor = .white
        
        self.view.addSubview(titleLabel)
        self.view.addSubview(contentLabel)
        self.view.addSubview(teamCodeLabel)
        self.view.addSubview(teamCodeCopyButton)
        self.view.addSubview(nextButton)
    }
    
    private func setupConstraint() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(CGFloat.screenHeight / 4.15)
            make.leading.equalToSuperview().offset(24)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(24)
        }
        
        teamCodeLabel.snp.makeConstraints { make in
            make.top.equalTo(contentLabel.snp.bottom).offset(56)
            make.leading.equalToSuperview().offset(24)
        }
        
        teamCodeCopyButton.snp.makeConstraints { make in
            make.leading.equalTo(teamCodeLabel.snp.trailing).offset(4)
            make.top.equalTo(contentLabel.snp.bottom).offset(53)
            make.width.equalTo(32)
            make.height.equalTo(32)
        }
        
        nextButton.snp.makeConstraints { make in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).inset(8)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(58)
        }
    }
    
    private func setupObserver() {
        //mvvm 연결 하여 이름, 팀 코드 가져오기
        
        let underlineAttriString = NSAttributedString(string: "팀코드",
                                                  attributes: [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue])
        teamCodeLabel.attributedText = underlineAttriString
    }
    
    @objc private func copyButtonAction() {
        if let teamCode = teamCodeLabel.text {
            UIPasteboard.general.string = teamCode
        }
    }
    
    @objc private func nextButtonAction() {
        if let storedString = UIPasteboard.general.string {
                    print(storedString)
        }
    }
}
