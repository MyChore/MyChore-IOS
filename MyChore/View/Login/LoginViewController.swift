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
    }
    
    private func setUpView() {
        self.view.addSubview(logoTitleLabel)
        self.view.addSubview(logoImageView)
        self.view.addSubview(messageImageView)
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
    }
    
}
