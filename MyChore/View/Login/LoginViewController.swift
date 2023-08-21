//
//  LoginViewController.swift
//  MyChore
//
//  Created by 유상 on 2023/07/27.
//

import UIKit
import SnapKit

class LoginViewController: UIViewController {
    
    private let logoTitleLabel = UILabel()
    private let logoImageView = UIImageView()
    private let messageImageView = UIImageView()
    
    // 임시 버튼 - 추후 카카오, 애플 로그인으로 변경 예정
    private let kakaoButton = UIButton()
    private let appleButton = UIButton()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setupView()
        setupConstraint()
        setupObserver()
    }
    
    private func setup() {
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
    
    private func setupView() {
        self.view.addSubview(logoTitleLabel)
        self.view.addSubview(logoImageView)
        self.view.addSubview(messageImageView)
        self.view.addSubview(kakaoButton)
        self.view.addSubview(appleButton)
    }
    
    private func setupConstraint() {
        logoTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(CGFloat.screenHeight / 3)
            make.centerX.equalToSuperview()
        }
        
        logoImageView.snp.makeConstraints { make in
            make.top.equalTo(logoTitleLabel.snp.bottom).offset(0)
            make.centerX.equalToSuperview()
        }
        
        
        
        appleButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-69)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
        }
        
        kakaoButton.snp.makeConstraints { make in
            make.bottom.equalTo(appleButton.snp.top).offset(-10)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
        }
        
        messageImageView.snp.makeConstraints { make in
            make.bottom.equalTo(kakaoButton.snp.top).offset(-15)
            make.centerX.equalToSuperview()
        }
        
       
    }
    
    private func setupObserver() {
        LoginViewModel.shared.getIsJoin { isJoin in
            if isJoin {
                // 메인 화면으로 넘어가기
            }else {
                let agreementVC = AgreementViewController()
                self.navigationController?.pushViewController(agreementVC, animated: true)
            }
        }
    }
    
    
    @objc private func login() {
        LoginViewModel.shared.loginWithKakao()
    }
    
}
