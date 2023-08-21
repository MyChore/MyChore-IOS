//
//  AddFloorSecondViewController.swift
//  MyChore
//
//  Created by 유상 on 2023/08/22.
//

import UIKit

class AddFloorSecondViewController: UIViewController {
    private let waringText = "한글/영어/밑줄/숫자만 사용할 수 있습니다. (8글자 이내)"
    
    
    private let titleLabel = UILabel()

    
    private let floorNameTextField = UITextField()
    
    private let lineView = UIView()
    
    private let infoLabel = UILabel()
    
    private let nextButton = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setupView()
        setupConstraint()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        lineView.backgroundColor = UIColor.mcGrey300
    }
    
    
    private func setup() {
        self.view.backgroundColor = UIColor.white
        
        titleLabel.numberOfLines = 0
        titleLabel.text = "평면도 이름을\n정해주세요"
        titleLabel.font = UIFont.systemFont(ofSize: 28)
        
        floorNameTextField.placeholder = "ex) 00이의 평면도"
        floorNameTextField.font = UIFont.systemFont(ofSize: 18)
        floorNameTextField.delegate = self
        
        infoLabel.font = UIFont.systemFont(ofSize: 12)
        infoLabel.textColor = .mcGrey600
        
        
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
        
        self.view.addSubview(floorNameTextField)
        self.view.addSubview(lineView)
        self.view.addSubview(infoLabel)
        self.view.addSubview(nextButton)
    }
    
    private func setupConstraint() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaInsets).offset(63)
            make.left.equalToSuperview().offset(24)
        }
        
        
        floorNameTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(64)
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
        }
        
        lineView.snp.makeConstraints { make in
            make.top.equalTo(floorNameTextField.snp.bottom).offset(2)
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
            make.height.equalTo(2)
        }
        
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(4)
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
        }
        
        nextButton.snp.makeConstraints { make in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).inset(8)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(58)
        }
        
    }
    
    
    
    func infoChange(check: Bool) {
        if check {
            lineView.backgroundColor = UIColor.mcMainGreen
            
            nextButton.isEnabled = true
            nextButton.backgroundColor = UIColor.mcMainGreen
        }else {
            lineView.backgroundColor = UIColor.red
            
            nextButton.isEnabled = false
            nextButton.backgroundColor = UIColor.mcGrey400
        }
    }
    
    @objc private func nextAction() {
        let nextVC = AddFloorThirdViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }

}

extension AddFloorSecondViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else {return false}
        
        let utf8Char = string.cString(using: .utf8)
        let isBackSpace = strcmp(utf8Char, "\\b")
        
        if isBackSpace == -92 {
            return true
        }
        
        if !string.hasCharacters(){
            infoChange(check: false)
        }else {
            infoChange(check: true)
        }
        
        return !(text.count > 8)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
