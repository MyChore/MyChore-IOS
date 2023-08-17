//
//  UserInfoViewController.swift
//  MyChore
//
//  Created by 유상 on 2023/08/03.
//

import UIKit

class UserInfoViewController: UIViewController {
    //추후 mvvm로 변경 예정
    private var isGender = false
    private var isBirth = false
    
    
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
            $0.addTarget(self, action: #selector(checkGender), for: .touchDown)
        }
        
        femaleButton.setTitle("여성", for: .normal)
        maleButton.setTitle("남성", for: .normal)
        
        birthLabel.text = "생년월일"
        birthLabel.font = UIFont.systemFont(ofSize: 22)
        
        
        var tag = 0
        
        [yearTextField, monthTextField, dayTextField].forEach {
            $0.font = UIFont.systemFont(ofSize: 22)
            $0.layer.cornerRadius = 10
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.mcGrey500.cgColor
            $0.keyboardType = .numberPad
            $0.tag = tag
            $0.delegate = self
            tag += 1
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
            make.height.equalTo(38)
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
    
    @objc private func checkGender(_ sender: UIButton) {
        [femaleButton, maleButton].forEach {
            if sender == $0 {
                $0.backgroundColor = .mcMainGreen
                $0.setTitleColor(.white, for: .normal)
                $0.isSelected = true
                if sender == femaleButton {
                    LoginViewModel.shared.setGender(gender: "여성")
                }else if sender == maleButton {
                    LoginViewModel.shared.setGender(gender: "남성")
                }
                
            }else {
                $0.backgroundColor = UIColor.mcGrey200
                $0.setTitleColor(.black, for: .normal)
                $0.isSelected = false
            }
        }
        isGender = true
        checkInfo()
    }
    
    private func checkInfo() {
        if isGender && isBirth {
            nextButton.isEnabled = true
            nextButton.backgroundColor = UIColor.mcMainGreen
        }else {
            nextButton.isEnabled = false
            nextButton.backgroundColor = UIColor.mcGrey400
        }
    }

    @objc private func nextAction() {
        if let year = yearTextField.text {
            if let month = monthTextField.text {
                if let day = dayTextField.text {
                    let birthString = year + "-" + month + "-" + day
                    
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd"
                    
                    let date = dateFormatter.date(from: birthString)
                    let birth = dateFormatter.string(from: date!)
                    
                    LoginViewModel.shared.setBirth(birth: birth)
                }
            }
        }
        
        let teamCodeVC = TeamCodeViewController()
        
        self.navigationController?.pushViewController(teamCodeVC, animated: true)
    }
}

extension UserInfoViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else {return false}
        
        let utf8Char = string.cString(using: .utf8)
        let isBackSpace = strcmp(utf8Char, "\\b")
        
        if isBackSpace == -92 {
            return true
        }
        
        if textField.tag == 0 {
            if text.count > 3 {
                return false
            }
        }else {
            if text.count > 1 {
                return false
            }
        }
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.layer.borderColor = UIColor.mcMainGreen.cgColor
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        var check = true
        [yearTextField, monthTextField, dayTextField].forEach {
            if let text = $0.text {
                if text.isEmpty {
                    check = false
                }else {
                    if $0.tag == 0 {
                        if text.count < 4 {
                            check = false
                        }
                    }
                }
            }
        }
        
        isBirth = check
        checkInfo()
    }
}
