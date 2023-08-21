//
//  NotificationSettingViewController.swift
//  MyChore
//
//  Created by 유상 on 2023/08/16.
//

import UIKit
import SnapKit

class NotificationSettingViewController: UIViewController {
    private let backButton = UIBarButtonItem()
    
    private let groupCompleteLabel = UILabel()
    private let groupCompleteSwitch = UISwitch()
    
    private let todayLabel = UILabel()
    private let todaySwitch = UISwitch()
    
    private let addGroupLabel = UILabel()
    private let addGroupSwitch = UISwitch()
    
    private let deleteGroupLabel = UILabel()
    private let deleteGroupSwitch = UISwitch()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setupView()
        setupConstraint()
    }
    
    
    
    private func setup() {
        self.view.backgroundColor = .white
        
        self.navigationItem.title = "알림 설정"
        
        let backImageButton = UIButton()
        backImageButton.setImage(UIImage(named: "back"), for: .normal)
        backImageButton.addTarget(self, action:  #selector(backAction), for: .touchDown)
        
        backButton.customView = backImageButton
        
        self.navigationItem.leftBarButtonItem = backButton
        
        [groupCompleteLabel, todayLabel, addGroupLabel, deleteGroupLabel].forEach {
            $0.font = .systemFont(ofSize: 18)
        }
        
        groupCompleteLabel.text = "그룹원의 집안일 완료 알림"
        todayLabel.text = "오늘의 집안일 알림"
        addGroupLabel.text = "그룸원 추가 알림"
        deleteGroupLabel.text = "그룹 삭제 알림"
        
        
    }
    
    private func setupView() {
        self.view.addSubview(groupCompleteLabel)
        self.view.addSubview(groupCompleteSwitch)
        self.view.addSubview(todayLabel)
        self.view.addSubview(todaySwitch)
        self.view.addSubview(addGroupLabel)
        self.view.addSubview(addGroupSwitch)
        self.view.addSubview(deleteGroupLabel)
        self.view.addSubview(deleteGroupSwitch)
    }
    
    private func setupConstraint() {
        groupCompleteLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(127)
            make.leading.equalToSuperview().offset(28)
        }
        
        groupCompleteSwitch.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(127)
            make.trailing.equalToSuperview().offset(-28)
        }
        
        todayLabel.snp.makeConstraints { make in
            make.top.equalTo(groupCompleteLabel.snp.bottom).offset(28)
            make.leading.equalToSuperview().offset(28)
        }
        
        todaySwitch.snp.makeConstraints { make in
            make.top.equalTo(groupCompleteLabel.snp.bottom).offset(28)
            make.trailing.equalToSuperview().offset(-28)
        }
        
        addGroupLabel.snp.makeConstraints { make in
            make.top.equalTo(todayLabel.snp.bottom).offset(28)
            make.leading.equalToSuperview().offset(28)
        }
        
        addGroupSwitch.snp.makeConstraints { make in
            make.top.equalTo(todayLabel.snp.bottom).offset(28)
            make.trailing.equalToSuperview().offset(-28)
        }
        
        deleteGroupLabel.snp.makeConstraints { make in
            make.top.equalTo(addGroupLabel.snp.bottom).offset(28)
            make.leading.equalToSuperview().offset(28)
        }
        
        deleteGroupSwitch.snp.makeConstraints { make in
            make.top.equalTo(addGroupLabel.snp.bottom).offset(28)
            make.trailing.equalToSuperview().offset(-28)
        }
    }
    
    
    @objc private func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
}
