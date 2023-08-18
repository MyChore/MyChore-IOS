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
    private let overlapText = "이미 있는 닉네임입니다."
    
    private let backButton = UIBarButtonItem()
    private let completeBarButton = UIBarButtonItem()
    
    private let profileView = UIView()
    private let profileImageView = UIImageView()
    private let imageAddButton = UIButton()
    
    private let nicknameLabel = UILabel()
    private let nicknameTextField = UITextField()
    private let infoLabel = UILabel()
    
    private let lineView = UIView()
    
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
        setupObserver()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        lineView.backgroundColor = UIColor.mcGrey300
    }
    
    
    private func setup() {
        self.navigationItem.title = "내 정보 변경"
        
        let backImageButton = UIButton()
        backImageButton.setImage(UIImage(named: "back"), for: .normal)
        backImageButton.addTarget(self, action:  #selector(backAction), for: .touchDown)
        
        backButton.customView = backImageButton
        
        completeBarButton.target = self
        completeBarButton.title = "완료"
        completeBarButton.action = #selector(nextAction)
        completeBarButton.tintColor = .mcMainGreen
        
        self.navigationItem.rightBarButtonItem = completeBarButton
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
        nicknameTextField.tag = 0
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
            $0.addTarget(self, action: #selector(checkGender), for: .touchDown)
        }
        
        birthLabel.text = "생년월일"
        birthLabel.font = .systemFont(ofSize: 18)
        
        [yearTextField, monthTextField, dayTextField].forEach {
            $0.font = .systemFont(ofSize: 20)
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.mcMainGreen.cgColor
            $0.layer.cornerRadius = 10
        }
        yearTextField.tag = 1
        monthTextField.tag = 2
        dayTextField.tag = 3
        
        emailLabel.text = "이메일"
        emailLabel.font = .systemFont(ofSize: 18)
        
        emailTextField.text = "이메일"
        emailTextField.font = UIFont.systemFont(ofSize: 18)
        emailTextField.isUserInteractionEnabled = false
        
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
        self.view.addSubview(lineView)
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
        
        lineView.snp.makeConstraints { make in
            make.top.equalTo(nicknameTextField.snp.bottom).offset(6)
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
            make.height.equalTo(2)

        }
        
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(6)
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
    
    private func setupObserver() {
        MypageViewModel.shared.getUserInfo { [self] userInfo in
            nicknameTextField.text = userInfo.nickname
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let date = dateFormatter.date(from: userInfo.birth)
            let calendar = Calendar.current
            let components = calendar.dateComponents([.year, .month, .day], from: date!)
            
            let year = components.year?.description
            let month = components.month?.description
            let day = components.day?.description
            
            yearTextField.text = year
            monthTextField.text = month
            dayTextField.text = day
            
            emailTextField.text = userInfo.email
            
            if userInfo.gender == "여성" {
                femaleButton.backgroundColor = .mcMainGreen
                femaleButton.setTitleColor(.white, for: .normal)
                femaleButton.isSelected = true
            }else {
                maleButton.backgroundColor = .mcMainGreen
                maleButton.setTitleColor(.white, for: .normal)
                maleButton.isSelected = true
            }
            
            
            if let imgUrl = userInfo.imgUrl {
                profileImageView.kf.setImage(with: URL(string: imgUrl))
            }
        }
        
        MypageViewModel.shared.getIsOverlap { [self] isOverlap in
            if isOverlap {
                lineView.backgroundColor = UIColor.mcMainGreen
                
                infoLabel.text = succesText
                infoLabel.textColor = UIColor.mcMainGreen
                infoLabel.isHidden = false
                
            }else {
                lineView.backgroundColor = UIColor.red
                
                infoLabel.text = overlapText
                infoLabel.textColor = UIColor.red
                infoLabel.isHidden = false
            }
        }
        
        MypageViewModel.shared.getIsSameNickname { [self] isSameNickname in
            if isSameNickname {
                infoLabel.text = waringText
                infoLabel.textColor = .mcGrey600
                
                lineView.backgroundColor = .mcGrey600
            }
        }
        
        MypageViewModel.shared.getIsChangeMyInfo { isChangeMyInfo in
            if isChangeMyInfo {
                MypageViewModel.shared.requestMyprofile()
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    @objc private func imageAdd() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        present(imagePicker, animated: true)
    }
    
   
    func infoChange(check: Bool) {
        if check {
            infoLabel.text = succesText
            infoLabel.textColor = UIColor.mcMainGreen
            infoLabel.isHidden = false
            
            lineView.backgroundColor = UIColor.mcMainGreen
        }else {
            infoLabel.text = waringText
            infoLabel.textColor = UIColor.red
            infoLabel.isHidden = false
            
            lineView.backgroundColor = UIColor.red
        }
    }
    
    @objc private func checkGender(_ sender: UIButton) {
        [femaleButton, maleButton].forEach {
            if sender == $0 {
                $0.backgroundColor = .mcMainGreen
                $0.setTitleColor(.white, for: .normal)
                $0.isSelected = true
                MypageViewModel.shared.checkGender(gender: ($0.titleLabel?.text)!)
            }else {
                $0.backgroundColor = UIColor.mcGrey200
                $0.setTitleColor(.black, for: .normal)
                $0.isSelected = false
            }
        }
    }
    
    
    @objc private func nextAction() {
        if MypageViewModel.shared.checkChangeMyInfo() {
            guard let nickname = nicknameTextField.text else {return}
            var gender: String = ""
            var birth: String = ""
            [femaleButton, maleButton].forEach {
                if $0.isSelected {
                    if let genderText = $0.titleLabel?.text {
                        gender = genderText
                    }
                }
            }
            
            if let year = yearTextField.text {
                if let month = monthTextField.text {
                    if let day = dayTextField.text {
                        let birthString = year + "-" + month + "-" + day
                        
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM-dd"
                        
                        let date = dateFormatter.date(from: birthString)
                        birth = dateFormatter.string(from: date!)
                    }
                }
            }
                    
            
            MypageViewModel.shared.changeMyInfo(nickname: nickname, gender: gender, birth: birth)
        }else {
            let alert = UIAlertController(title: "변경된 내용이 없습니다.", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "뒤로가기", style: .default))
            self.present(alert, animated: true)
        }
        
       
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
        
        if !string.hasCharacters(){
            infoChange(check: false)
        }
        
        return !(text.count > 8)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let nickname = textField.text else {return}
        MypageViewModel.shared.checkNickname(nickname: nickname)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension UserInfoChangeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.profileImageView.image = pickedImage
            
            MypageViewModel.shared.setProfileImage(image: pickedImage)
        }
        dismiss(animated: true, completion: nil)
    }
        
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
