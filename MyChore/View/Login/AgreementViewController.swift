//
//  AgreementViewController.swift
//  MyChore
//
//  Created by 유상 on 2023/07/28.
//

import UIKit
import SnapKit

class AgreementViewController: UIViewController {
    
    let titleLabel = UILabel()
    
    let allAgreeStackView = UIStackView()
    let allAgreeLabel = UILabel()
    let allAgreeCheckBox = UIButton()
    
    let lineView = UIView()
    
    let agree1StackView = UIStackView()
    let agree1Label = UILabel()
    let agree1CheckBox = UIButton()
    
    let agree2StackView = UIStackView()
    let agree2Label = UILabel()
    let agree2CheckBox = UIButton()
    
    let agree3StackView = UIStackView()
    let agree3Label = UILabel()
    let agree3CheckBox = UIButton()
    
    let agree4StackView = UIStackView()
    let agree4Label = UILabel()
    let agree4CheckBox = UIButton()
    
    let nextButton = UIButton()
    
    var agreeArray: [Bool] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setupLayout()
        setUpConstraint()
    }
    
    private func setup() {
        for _ in 0..<4 {
            agreeArray.append(false)
        }
        
        [allAgreeCheckBox, agree1CheckBox, agree2CheckBox, agree3CheckBox, agree4CheckBox].forEach {
            $0.layer.borderColor = UIColor.mcGrey500.cgColor
            $0.layer.borderWidth = 1
            $0.layer.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
            $0.layer.cornerRadius = 4
            
            $0.backgroundColor = UIColor.white
            
            $0.setImage(UIImage(named: "agree_check"), for: .normal)
            
            $0.adjustsImageWhenHighlighted = false
            
//            $0.configurationUpdateHandler = {
//                switch $0.state {
//                case .disabled:
//                    $0.imageView?.tintAdjustmentMode = .normal
//                    break
//                default:
//                    $0.imageView?.tintAdjustmentMode = .normal
//                    break
//                }
//            }
            
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
        
        lineView.layer.backgroundColor = UIColor.mcGrey300.cgColor
        lineView.layer.borderColor = UIColor.mcGrey300.cgColor
        lineView.layer.borderWidth = 2
        
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
    }
    
    private func setupLayout() {
        self.view.backgroundColor = UIColor.white
        
        self.view.addSubview(titleLabel)
        self.view.addSubview(allAgreeStackView)
        self.view.addSubview(lineView)
        self.view.addSubview(agree1StackView)
        self.view.addSubview(agree2StackView)
        self.view.addSubview(agree3StackView)
        self.view.addSubview(agree4StackView)
    }
    
    private func setUpConstraint() {
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
    }
    
    
    
    @objc private func aggreAction(_ sender: UIButton) {
        if sender == allAgreeCheckBox {
            
        }
        
        sender.backgroundColor = UIColor.mcMainGreen
    }
    
    
    
}
