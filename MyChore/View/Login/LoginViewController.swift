//
//  LoginViewController.swift
//  MyChore
//
//  Created by 유상 on 2023/07/27.
//

import UIKit
import SnapKit

class LoginViewController: UIViewController {
    
    let logoTitleLabel = UILabel()
    let logoImageView = UIImageView()
    let messageImageView = UIImageView()
    
    // 임시 버튼 - 추후 카카오, 애플 로그인으로 변경 예정
    let kakaoButton = UIButton()
    let appleButton = UIButton()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
        setUpView()
        setUpConstraint()
    }
    
    private func setUp() {
        self.view.backgroundColor = UIColor.white
        
        logoTitleLabel.text = "집안일도 내게 맞춰서"
        logoTitleLabel.font = UIFont.systemFont(ofSize: 22)
        
        logoImageView.image = UIImage(named: "login_logotype")
        
        messageImageView.image = UIImage(named: "login_message")
        
        kakaoButton.setImage(UIImage(named: "login_kakao"), for: .normal)
        kakaoButton.addTarget(self, action: #selector(login), for: .touchDown)
        
        appleButton.setImage(UIImage(named: "login_apple"), for: .normal)
        appleButton.addTarget(self, action: #selector(login), for: .touchDown)
    }
    
    private func setUpView() {
        self.view.addSubview(logoTitleLabel)
        self.view.addSubview(logoImageView)
        self.view.addSubview(messageImageView)
        self.view.addSubview(kakaoButton)
        self.view.addSubview(appleButton)
    }
    
    private func setUpConstraint() {
        logoTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(252)
            make.centerX.equalToSuperview()
        }
        
        logoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(302)
            make.centerX.equalToSuperview()
        }
        
        messageImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(642)
            make.centerX.equalToSuperview()
        }
        
        kakaoButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(703)
            make.centerX.equalToSuperview()
        }
        
        appleButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(765)
            make.centerX.equalToSuperview()
        }
    }
    
    
    @objc private func login() {
        print("버튼 동작")
    }
    
}
