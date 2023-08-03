//
//  UserInfoViewController.swift
//  MyChore
//
//  Created by 유상 on 2023/08/03.
//

import UIKit

class UserInfoViewController: UIViewController {
    
    private let titleLabel = UILabel()
    
    private let genderLabel = UILabel()
    private let genderStackView = UIStackView()
    private let femaleButton = UIButton()
    private let maleButton = UIButton()
    
    private let birthLabel = UILabel()
    private let birthStackView = UIStackView()
    private let yearTextField = UITextField()
    private let monthTextField = UITextField()
    private let dayTextField = UITextField()
    
    private let nextButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setupView()
        setupConstraint()
    }
    
    private func setup() {
        self.view.backgroundColor = UIColor.white
        
        titleLabel.numberOfLines = 0
        titleLabel.text = "성별과 생년월일을\n입력해주세요"
        titleLabel.font = UIFont.systemFont(ofSize: 28)
        
        genderLabel.text = "성별"
        genderLabel.font = UIFont.systemFont(ofSize: 22)
        
        
        [genderStackView, birthStackView].forEach {
            $0.axis = .horizontal
            $0.spacing = 10
        }
        
        genderStackView.distribution = .fillEqually
        birthStackView.distribution = .fillProportionally
        
        
        [femaleButton, maleButton].forEach {
            $0.titleLabel?.font = UIFont.systemFont(ofSize: 18)
            $0.backgroundColor = UIColor.mcGrey200
            $0.setTitleColor(.black, for: .normal)
            $0.layer.cornerRadius = 10
            $0.isSelected = false
        }
        
        femaleButton.setTitle("여성", for: .normal)
        maleButton.setTitle("남성", for: .normal)
        
        birthLabel.text = "생년월일"
        birthLabel.font = UIFont.systemFont(ofSize: 22)
        
        
        [yearTextField, monthTextField, dayTextField].forEach {
            $0.font = UIFont.systemFont(ofSize: 22)
            $0.layer.cornerRadius = 10
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.mcGrey500.cgColor
        }
        
        yearTextField.placeholder = "YYYY"
        monthTextField.placeholder = "MM"
        dayTextField.placeholder = "DD"
        
        nextButton.setTitle("다음", for: .normal)
        nextButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        nextButton.tintColor = UIColor.white
        nextButton.backgroundColor = UIColor.mcGrey400
        nextButton.isEnabled = false
        
        nextButton.addTarget(self, action: #selector(nextAction), for: .touchDown)
        nextButton.layer.cornerRadius = 10
    }
    
    private func setupView() {
        self.view.addSubview(titleLabel)
        
        self.view.addSubview(genderLabel)
        genderStackView.addArrangedSubview(femaleButton)
        genderStackView.addArrangedSubview(maleButton)
        self.view.addSubview(genderStackView)
        
        self.view.addSubview(birthLabel)
        birthStackView.addArrangedSubview(yearTextField)
        birthStackView.addArrangedSubview(monthTextField)
        birthStackView.addArrangedSubview(dayTextField)
        self.view.addSubview(birthStackView)
        
        self.view.addSubview(nextButton)
    }
    
    private func setupConstraint() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(119)
            make.left.equalToSuperview().offset(24)
        }
        
        genderLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(64)
            make.left.equalToSuperview().offset(24)
        }
        
        genderStackView.snp.makeConstraints { make in
            make.top.equalTo(genderLabel.snp.bottom).offset(14)
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-250)
        }
        
        birthLabel.snp.makeConstraints { make in
            make.top.equalTo(genderStackView.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(24)
        }
        
        birthStackView.snp.makeConstraints { make in
            make.top.equalTo(birthLabel.snp.bottom).offset(18)
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-173)
            make.height.equalTo(44)
        }
        
        nextButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-21)
            make.left.equalToSuperview().offset(25)
            make.right.equalToSuperview().offset(-24)
            make.height.equalTo(58)
        }
    }
    

    @objc private func nextAction() {
        print("다음")
    }
}
