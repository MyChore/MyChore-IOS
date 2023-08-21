//
//  NicknameViewController.swift
//  MyChore
//
//  Created by 유상 on 2023/08/03.
//

import UIKit

class TeamCodeViewController: UIViewController {
    private let titleLabel = UILabel()
    
    private let teamCodeTextField = UITextField()
    
    private let lineView = UIView()
    
    private let infoLabel = UILabel()
    
    private let nextButton = UIButton()
    
    
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
        self.view.backgroundColor = UIColor.white
        
        titleLabel.numberOfLines = 0
        titleLabel.text = "그룹코드를\n입력해주세요"
        titleLabel.font = UIFont.systemFont(ofSize: 28)
        
        teamCodeTextField.placeholder = "초대코드를 입력해주세요"
        teamCodeTextField.font = UIFont.systemFont(ofSize: 18)
        teamCodeTextField.delegate = self
        
        infoLabel.text = "초대 코드가 없다면 다음으로 넘어가주세요."
        infoLabel.font = UIFont.systemFont(ofSize: 12)
        infoLabel.textColor = UIColor.mcGrey600
        
        
        nextButton.setTitle("다음", for: .normal)
        nextButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        nextButton.tintColor = UIColor.white
        nextButton.backgroundColor = .mcMainGreen
        
        nextButton.addTarget(self, action: #selector(nextAction), for: .touchDown)
        nextButton.layer.cornerRadius = 10
    }
    
    private func setupView() {
        self.view.addSubview(titleLabel)
        self.view.addSubview(teamCodeTextField)
        self.view.addSubview(lineView)
        self.view.addSubview(infoLabel)
        self.view.addSubview(nextButton)
    }
    
    private func setupConstraint() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(119)
            make.left.equalToSuperview().offset(24)
        }
        
        teamCodeTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(64)
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
        }
        
        lineView.snp.makeConstraints { make in
            make.top.equalTo(teamCodeTextField.snp.bottom).offset(2)
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
            make.bottom.equalToSuperview().offset(-21)
            make.left.equalToSuperview().offset(25)
            make.right.equalToSuperview().offset(-24)
            make.height.equalTo(58)
        }
        
    }
    
    
    @objc private func nextAction() {
        if let teamCode = teamCodeTextField.text {
            if teamCode == "" {
                LoginViewModel.shared.join()
            }else {
                print("Alert 창 띄우기")
            }
        }else {
            LoginViewModel.shared.join()
        }
    }
    
    private func setupObserver() {
        LoginViewModel.shared.getAccessToken { token in
            if token == "" {
                print("회원 가입 실패")
            }else {
                // 메인 화면으로 넘어가기
                print("회원 가입 성공 -> 메인화면으로 넘어가기")
                let homeVC = HomeViewController()
                self.navigationController?.pushViewController(homeVC, animated: true)
            }
        }
    }

}

extension TeamCodeViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        lineView.backgroundColor = .mcMainGreen
        
        return true
    }
}
