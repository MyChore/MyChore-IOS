//
//  NicknameViewController.swift
//  MyChore
//
//  Created by 유상 on 2023/08/03.
//

import UIKit

class NicknameViewController: UIViewController {
    private let succesText = "사용 가능한 닉네임입니다"
    private let waringText = "한글/영어/밑줄/숫자만 사용할 수 있습니다. (8글자 이내)"
    
    
    private let titleLabel = UILabel()
    
    private let profileView = UIView()
    private let profileImageView = UIImageView()
    private let imageAddButton = UIButton()
    
    private let nicknameTextField = UITextField()
    
    private let lineView = UIView()
    
    private let infoLabel = UILabel()
    
    
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
        titleLabel.text = "닉네임과 프로필 사진을\n설정해주세요"
        titleLabel.font = UIFont.systemFont(ofSize: 28)
        
        
        profileImageView.backgroundColor = UIColor.mcGrey300
        profileImageView.layer.cornerRadius = 50
        
        imageAddButton.backgroundColor = UIColor.mcGrey700
        imageAddButton.setImage(UIImage(named: "image_add"), for: .normal)
        imageAddButton.addTarget(self, action: #selector(imageAdd), for: .touchDown)
        imageAddButton.layer.cornerRadius = 16
        
        nicknameTextField.placeholder = "한글/영어/숫자/밑줄 조합 (8글자 이내)"
        nicknameTextField.font = UIFont.systemFont(ofSize: 18)
        nicknameTextField.delegate = self
        
        infoLabel.isHidden = true
        infoLabel.font = UIFont.systemFont(ofSize: 12)
        infoLabel.textColor = UIColor.mcMainGreen
    }
    
    private func setupView() {
        self.view.addSubview(titleLabel)
        
        profileView.addSubview(profileImageView)
        profileView.addSubview(imageAddButton)
        
        self.view.addSubview(profileView)
        self.view.addSubview(nicknameTextField)
        self.view.addSubview(lineView)
        self.view.addSubview(infoLabel)
    }
    
    private func setupConstraint() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(119)
            make.left.equalToSuperview().offset(24)
        }
        
        profileView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(165)
            make.right.equalToSuperview().offset(-156)
            make.width.equalTo(107)
            make.height.equalTo(105)
        }
        
        profileImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.right.equalToSuperview().offset(-7)
            make.width.equalTo(100)
            make.height.equalTo(100)
        }
        
        imageAddButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(73)
            make.left.equalToSuperview().offset(45)
            make.width.equalTo(32)
            make.height.equalTo(32)
        }
        
        nicknameTextField.snp.makeConstraints { make in
            make.top.equalTo(profileView.snp.bottom).offset(15)
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
        }
        
        lineView.snp.makeConstraints { make in
            make.top.equalTo(nicknameTextField.snp.bottom).offset(2)
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
            make.height.equalTo(2)
        }
        
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(4)
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
        }
        
    }
    
    @objc private func imageAdd() {
        print("이미지 추가")
    }
    
    func infoChange(check: Bool) {
        if check {
            lineView.backgroundColor = UIColor.mcMainGreen
            
            infoLabel.text = succesText
            infoLabel.textColor = UIColor.mcMainGreen
            infoLabel.isHidden = false
        }else {
            lineView.backgroundColor = UIColor.red
            
            infoLabel.text = waringText
            infoLabel.textColor = UIColor.red
            infoLabel.isHidden = false
        }
    }
    

}

extension NicknameViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else {return false}
        
        let utf8Char = string.cString(using: .utf8)
        let isBackSpace = strcmp(utf8Char, "\\b")
        
        if isBackSpace == -92 {
            return true
        }
        
        if text.count > 8 {
            return false
        }else {
            if string.hasCharacters(){
                infoChange(check: true)
                return true
            }else {
                infoChange(check: false)
                return true
            }
        }
    }
}
