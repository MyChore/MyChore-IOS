//
//  UserInfoChangeViewController.swift
//  MyChore
//
//  Created by 유상 on 2023/08/15.
//

import UIKit

class UserInfoChangeViewController: UIViewController {
    private let succesText = "사용 가능한 닉네임입니다"
    private let waringText = "한글/영어/밑줄/숫자만 사용할 수 있습니다. (8글자 이내)"
    
    private let backButton = UIBarButtonItem()
    private let completeButton = UIBarButtonItem()
    
    private let profileView = UIView()
    private let profileImageView = UIImageView()
    private let imageAddButton = UIButton()
    
    private let nicknameLabel = UILabel()
    private let nicknameTextField = UITextField()
    private let infoLabel = UILabel()
    
    private let genderLabel = UILabel()
    private let femaleButton = UIButton()
    private let maleButton = UIButton()
    
    private let birthLabel = UILabel()
    private let yearTextField = UITextField()
    private let monthTextField = UITextField()
    private let dayTextField = UITextField()
    
    private let emailLabel = UILabel()
    private let emailTextField = UITextField()
    
    private let deleteButton = UIButton()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setupView()
        setupConstraint()
    }
    
    
    
    private func setup() {
        self.navigationItem.title = "내 정보 변경"
        
        let backImageButton = UIButton()
        backImageButton.setImage(UIImage(named: "back"), for: .normal)
        backImageButton.addTarget(self, action:  #selector(backAction), for: .touchDown)
        
        backButton.customView = backImageButton
        
        
        
        completeButton.title = "완료"
        completeButton.tintColor = .mcMainGreen
        
        self.navigationItem.rightBarButtonItem = completeButton
        self.navigationItem.leftBarButtonItem = backButton
        
        
        self.view.backgroundColor = UIColor.white
        
        profileImageView.backgroundColor = .mcGrey400
        profileImageView.layer.cornerRadius = 50
        
        imageAddButton.backgroundColor = UIColor.mcGrey700
        imageAddButton.setImage(UIImage(named: "image_add"), for: .normal)
        imageAddButton.addTarget(self, action: #selector(imageAdd), for: .touchDown)
        imageAddButton.layer.cornerRadius = 16
        
        nicknameLabel.text = "이름"
        nicknameLabel.font = .systemFont(ofSize: 18)
        
        // 추후 api 연결 후 변경
        nicknameTextField.text = "닉네임"
        nicknameTextField.font = UIFont.systemFont(ofSize: 18)
        nicknameTextField.delegate = self
        
        infoLabel.font = UIFont.systemFont(ofSize: 12)
        infoLabel.text = waringText
        infoLabel.textColor = .mcGrey600
        
        genderLabel.text = "성별"
        
        femaleButton.setTitle("여성", for: .normal)
        maleButton.setTitle("남성", for: .normal)
        
        [femaleButton, maleButton].forEach {
            $0.tintColor = .black
            $0.backgroundColor = .mcGrey200
            $0.layer.cornerRadius = 10
        }
        
        birthLabel.text = "생년월일"
        birthLabel.font = .systemFont(ofSize: 18)
        
        [yearTextField, monthTextField, dayTextField].forEach {
            $0.font = .systemFont(ofSize: 20)
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.mcMainGreen.cgColor
            $0.layer.cornerRadius = 10
        }
        
        emailLabel.text = "이메일"
        emailLabel.font = .systemFont(ofSize: 18)
        
        emailTextField.text = "이메일"
        emailTextField.font = UIFont.systemFont(ofSize: 18)
        
        deleteButton.setTitle("회원 탈퇴", for: .normal)
        deleteButton.setUnderline()
        deleteButton.tintColor = .mcGrey600
        deleteButton.titleLabel?.font = .systemFont(ofSize: 14)
    }
    
    private func setupView() {
        
        profileView.addSubview(profileImageView)
        profileView.addSubview(imageAddButton)
        
        self.view.addSubview(profileView)
        self.view.addSubview(nicknameLabel)
        self.view.addSubview(nicknameTextField)
        self.view.addSubview(infoLabel)
        self.view.addSubview(genderLabel)
        self.view.addSubview(femaleButton)
        self.view.addSubview(maleButton)
        self.view.addSubview(birthLabel)
        self.view.addSubview(yearTextField)
        self.view.addSubview(monthTextField)
        self.view.addSubview(dayTextField)
        self.view.addSubview(emailLabel)
        self.view.addSubview(emailTextField)
        self.view.addSubview(deleteButton)
        
    }
    
    private func setupConstraint() {
        profileView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(120)
            make.centerX.equalToSuperview()
            make.width.equalTo(107)
            make.height.equalTo(105)
        }
        
        profileImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(100)
        }
        
        imageAddButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(73)
            make.left.equalToSuperview().offset(70)
            make.width.equalTo(32)
            make.height.equalTo(32)
        }
        
        nicknameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileView.snp.bottom).offset(24)
            make.left.equalToSuperview().offset(24)
        }
        
        nicknameTextField.snp.makeConstraints { make in
            make.top.equalTo(nicknameLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
        }
        
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(nicknameTextField.snp.bottom).offset(6)
            make.left.equalToSuperview().offset(24)
        }
        
        genderLabel.snp.makeConstraints { make in
            make.top.equalTo(infoLabel.snp.bottom).offset(23)
            make.left.equalToSuperview().offset(24)
        }
        
        femaleButton.snp.makeConstraints { make in
            make.top.equalTo(genderLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(24)
            make.width.equalTo(72)
            make.height.equalTo(38)
        }
        
        maleButton.snp.makeConstraints { make in
            make.top.equalTo(genderLabel.snp.bottom).offset(10)
            make.left.equalTo(femaleButton.snp.right).offset(10)
            make.width.equalTo(72)
            make.height.equalTo(38)
        }
        
        birthLabel.snp.makeConstraints { make in
            make.top.equalTo(maleButton.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(24)
        }
        
        yearTextField.snp.makeConstraints { make in
            make.top.equalTo(birthLabel.snp.bottom).offset(6)
            make.left.equalToSuperview().offset(24)
            make.width.equalTo(81)
            make.height.equalTo(44)
        }
        
        monthTextField.snp.makeConstraints { make in
            make.top.equalTo(birthLabel.snp.bottom).offset(6)
            make.left.equalTo(yearTextField.snp.right).offset(10)
            make.width.equalTo(65)
            make.height.equalTo(44)
        }
        
        dayTextField.snp.makeConstraints { make in
            make.top.equalTo(birthLabel.snp.bottom).offset(6)
            make.left.equalTo(monthTextField.snp.right).offset(10)
            make.width.equalTo(65)
            make.height.equalTo(44)
        }
        
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(yearTextField.snp.bottom).offset(40)
            make.left.equalToSuperview().offset(24)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
        }
        
        deleteButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(44)
            make.centerX.equalToSuperview()
            make.height.equalTo(30)
        }
       
        
    }
    
    @objc private func imageAdd() {
        print("이미지 추가")
    }
    
    func infoChange(check: Bool) {
        if check {
            infoLabel.text = succesText
            infoLabel.textColor = UIColor.mcMainGreen
            infoLabel.isHidden = false
            
        }else {
            infoLabel.text = waringText
            infoLabel.textColor = UIColor.red
            infoLabel.isHidden = false
            
        }
    }
    
    @objc private func nextAction() {
        let userInfoViewController = UserInfoViewController()
        
        self.navigationController?.pushViewController(userInfoViewController, animated: true)
    }
    
    
    @objc private func backAction() {
        self.navigationController?.popViewController(animated: true)
    }

}

extension UserInfoChangeViewController: UITextFieldDelegate {
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
