//
//  MypageMainViewController.swift
//  MyChore
//
//  Created by 유상 on 2023/08/15.
//

import UIKit
import SnapKit
import Kingfisher


class MypageMainViewController: UIViewController {
    private let titleList = ["알림", "공지사항", "문의하기", "정보"]
    private let titleImageList = ["notification", "notice", "qa", "info"]

    
    private let logoutButton = UIBarButtonItem()
    
    private let profileImageView = UIImageView()
    private let nicknameLabel = UILabel()
    private let profileChangeButton = UIButton()
    
    private let pageTableView = UITableView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setupView()
        setupConstraint()
        setupObserver()
    }
    
    private func setup() {
        self.navigationItem.title = "My Page"
        
        logoutButton.title = "로그아웃"
        logoutButton.tintColor = .mcGrey600
        logoutButton.target = self
        logoutButton.action = #selector(logout)
        
        
        self.navigationItem.rightBarButtonItem = logoutButton
        
        
        self.view.backgroundColor = UIColor(red: 0.922, green: 0.969, blue: 0.949, alpha: 1)
        
        profileImageView.backgroundColor = .white
        profileImageView.layer.cornerRadius = 50
        
        nicknameLabel.font = .systemFont(ofSize: 24)
        nicknameLabel.text = "닉네임"
        
        profileChangeButton.backgroundColor = .mcMainGreen
        profileChangeButton.tintColor = .white
        profileChangeButton.setTitle("내 정보 변경", for: .normal)
        profileChangeButton.titleLabel?.font = .systemFont(ofSize: 14)
        profileChangeButton.layer.cornerRadius = 10
        
        profileChangeButton.addTarget(self, action: #selector(changeMyInfo), for: .touchDown)
        
        pageTableView.backgroundColor = .white
        pageTableView.dataSource = self
        pageTableView.delegate = self
        pageTableView.register(MyPageCell.self, forCellReuseIdentifier: "cell")
        
        pageTableView.separatorInset.left = 35
        pageTableView.separatorInset.right = 35
    }
    
    override func viewWillAppear(_ animated: Bool) {
        MypageViewModel.shared.doneChnageMyprofile()
    }
    
    private func setupView() {
        self.view.addSubview(profileImageView)
        self.view.addSubview(nicknameLabel)
        self.view.addSubview(profileChangeButton)
        self.view.addSubview(pageTableView)
    }
    
    private func setupConstraint() {
        profileImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(118)
            make.centerX.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(100)
        }
        
        nicknameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(32)
        }
        
        profileChangeButton.snp.makeConstraints { make in
            make.top.equalTo(nicknameLabel.snp.bottom).offset(22)
            make.centerX.equalToSuperview()
            make.width.equalTo(92)
            make.height.equalTo(36)
        }
        
        pageTableView.snp.makeConstraints { make in
            make.top.equalTo(profileChangeButton.snp.bottom).offset(46)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    private func setupObserver() {
        MypageViewModel.shared.getUserInfo { [self] userInfo in
            nicknameLabel.text = userInfo.nickname
            
            if let imgUrl = userInfo.imgUrl {
                profileImageView.kf.setImage(with: URL(string: imgUrl))
            }
        }
    }
    
    
    @objc private func changeMyInfo() {
        let userInfoVC = UserInfoChangeViewController()
        
        self.navigationController?.pushViewController(userInfoVC, animated: true)
    }
    
    @objc private func logout() {
        MypageViewModel.shared.logout()
    }

}

extension MypageMainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MyPageCell
        
        cell.setupTitle(title: titleList[indexPath.row], image: titleImageList[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            //알림
            let notificationVC = NotificationSettingViewController()
            self.navigationController?.pushViewController(notificationVC, animated: true)
            break
        case 1:
            //공지사항
            break
        case 2:
            //문의하기
            break
        case 3:
            //정보
            let infoVC = InfoViewController()
            self.navigationController?.pushViewController(infoVC, animated: true)
            break
        default:
            break
        }
    }
    
    
}
