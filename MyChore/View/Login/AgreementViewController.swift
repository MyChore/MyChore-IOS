//
//  AgreementViewController.swift
//  MyChore
//
//  Created by 유상 on 2023/07/28.
//

import UIKit
import SnapKit

class AgreementViewController: UIViewController {
    
    private let titleLabel = UILabel()
    
    private let allAgreeStackView = UIStackView()
    private let allAgreeLabel = UILabel()
    private let allAgreeCheckBox = UIButton()
    
    private let lineView = UIView()
    
    private let agree1StackView = UIStackView()
    private let agree1Label = UILabel()
    private let agree1CheckBox = UIButton()
    
    private let agree2StackView = UIStackView()
    private let agree2Label = UILabel()
    private let agree2CheckBox = UIButton()
    
    private let agree3StackView = UIStackView()
    private let agree3Label = UILabel()
    private let agree3CheckBox = UIButton()
    
    private let agree4StackView = UIStackView()
    private let agree4Label = UILabel()
    private let agree4CheckBox = UIButton()
    
    private let nextButton = UIButton()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setupView()
        setupConstraint()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        lineView.layer.backgroundColor = UIColor.mcGrey300.cgColor
    }
    
    private func setup() {
        [allAgreeCheckBox, agree1CheckBox, agree2CheckBox, agree3CheckBox, agree4CheckBox].forEach {
            $0.layer.borderColor = UIColor.mcGrey500.cgColor
            $0.layer.borderWidth = 1
            $0.layer.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
            $0.layer.cornerRadius = 4
            
            $0.backgroundColor = UIColor.white
            
            $0.setImage(UIImage(named: "agree_check"), for: .normal)
            
            $0.adjustsImageWhenHighlighted = false
            
            $0.addTarget(self, action: #selector(aggreAction), for: .touchDown)
        }
        
        [allAgreeStackView, agree1StackView, agree2StackView, agree3StackView, agree4StackView].forEach {
            $0.axis = .horizontal
            $0.alignment = .center
            $0.distribution = .fill
        }
        
        
        titleLabel.text = "약관동의"
        titleLabel.font = UIFont.systemFont(ofSize: 34)
        
        allAgreeLabel.text = "전체 동의합니다."
        allAgreeLabel.font = UIFont.systemFont(ofSize: 22)
        
        
        [allAgreeLabel, allAgreeCheckBox].forEach {
            allAgreeStackView.addArrangedSubview($0)
        }
        
        
        
        agree1Label.text = "만 14세 이상입니다."
        agree1Label.font = UIFont.systemFont(ofSize: 16)
        
        [agree1Label, agree1CheckBox].forEach {
            agree1StackView.addArrangedSubview($0)
        }
        
        agree2Label.text = "서비스 이용약관 (필수)"
        agree2Label.font = UIFont.systemFont(ofSize: 16)
        
        [agree2Label, agree2CheckBox].forEach {
            agree2StackView.addArrangedSubview($0)
        }
        
        agree3Label.text = "개인 정보 수집 및 이용 동의 (필수)"
        agree3Label.font = UIFont.systemFont(ofSize: 16)
        
        [agree3Label, agree3CheckBox].forEach {
            agree3StackView.addArrangedSubview($0)
        }
        
        agree4Label.text = "이메일 수신동의 (선택)"
        agree4Label.font = UIFont.systemFont(ofSize: 16)
        
        [agree4Label, agree4CheckBox].forEach {
            agree4StackView.addArrangedSubview($0)
        }
        
        nextButton.setTitle("다음", for: .normal)
        nextButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        nextButton.tintColor = UIColor.white
        nextButton.backgroundColor = UIColor.mcGrey400
        nextButton.isEnabled = false
        
        nextButton.addTarget(self, action: #selector(nextAction), for: .touchDown)
        nextButton.layer.cornerRadius = 10
    }
    
    private func setupView() {
        self.view.backgroundColor = UIColor.white
        
        self.view.addSubview(titleLabel)
        self.view.addSubview(allAgreeStackView)
        self.view.addSubview(lineView)
        self.view.addSubview(agree1StackView)
        self.view.addSubview(agree2StackView)
        self.view.addSubview(agree3StackView)
        self.view.addSubview(agree4StackView)
        self.view.addSubview(nextButton)
    }
    
    private func setupConstraint() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(162)
            make.left.equalToSuperview().offset(20)
        }
        
        allAgreeStackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(74)
            make.left.equalToSuperview().offset(25)
            make.right.equalToSuperview().offset(-24)
        }
        
        lineView.snp.makeConstraints { make in
            make.top.equalTo(allAgreeStackView.snp.bottom).offset(12)
            make.left.equalToSuperview().offset(25)
            make.right.equalToSuperview().offset(-24)
            make.height.equalTo(1)
        }
        
        agree1StackView.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(24)
            make.left.equalToSuperview().offset(25)
            make.right.equalToSuperview().offset(-24)
        }

        agree2StackView.snp.makeConstraints { make in
            make.top.equalTo(agree1StackView.snp.bottom).offset(22)
            make.left.equalToSuperview().offset(25)
            make.right.equalToSuperview().offset(-24)
        }

        agree3StackView.snp.makeConstraints { make in
            make.top.equalTo(agree2StackView.snp.bottom).offset(22)
            make.left.equalToSuperview().offset(25)
            make.right.equalToSuperview().offset(-24)
        }

        agree4StackView.snp.makeConstraints { make in
            make.top.equalTo(agree3StackView.snp.bottom).offset(22)
            make.left.equalToSuperview().offset(25)
            make.right.equalToSuperview().offset(-24)
        }
        
        nextButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-21)
            make.left.equalToSuperview().offset(25)
            make.right.equalToSuperview().offset(-24)
            make.height.equalTo(58)
        }
    }
    
    
    
    @objc private func aggreAction(_ sender: UIButton) {
        if sender == allAgreeCheckBox {
            if sender.isSelected {
                [allAgreeCheckBox, agree1CheckBox, agree2CheckBox, agree3CheckBox, agree4CheckBox].forEach {
                    $0.isSelected = false
                    $0.backgroundColor = UIColor.white
                }
            }else {
                [allAgreeCheckBox, agree1CheckBox, agree2CheckBox, agree3CheckBox, agree4CheckBox].forEach {
                    $0.isSelected = true
                    $0.backgroundColor = UIColor.mcMainGreen
                }
            }
        }else {
            if sender.isSelected {
                sender.isSelected = false
                sender.backgroundColor = UIColor.white
            }else {
                sender.isSelected = true
                sender.backgroundColor = UIColor.mcMainGreen
            }
        }
        
        checkAgree()
    }
    
    
    private func checkAgree() {
        var check = true
        [agree1CheckBox, agree2CheckBox, agree3CheckBox].forEach {
            if $0.isSelected == false {
                check = false
            }
        }
        
        if check {
            nextButton.isEnabled = true
            nextButton.backgroundColor = UIColor.mcMainGreen
        }else {
            nextButton.isEnabled = false
            nextButton.backgroundColor = UIColor.mcGrey400
        }
    }
    
    
    @objc private func nextAction() {
        let nicknameViewController = NicknameViewController()
        
        self.navigationController?.pushViewController(nicknameViewController, animated: true)
    }
    
}
