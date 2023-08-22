//
//  ManageMasterViewController.swift
//  MyChore
//
//  Created by sole on 2023/08/22.
//

import UIKit
import SnapKit

struct Group {
    var name: String
    var roomType: String
    var rooms: String
    var members: [Member]
    var completeRate: CGFloat
    var inviteCode: String
    var createdDate: Date
}

var group = Group(name: "우리집 좋아요",
                  roomType: "쓰리룸",
                  rooms: "방3 욕실2",
                  members: members,
                  completeRate: 0.74,
                  inviteCode: "AAAAAA",
                  createdDate: Date())

class ManageMasterViewController: ViewController {
    let titleLabel = UILabel()
    let groupNameLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .mcSubGreen100
        self.navigationController?.navigationBar.isHidden = true
        
        let titleBar = titleBar(title: "우리집 좋아요")
        
        let floorPlan: UIImageView = {
            let image = UIImage(named: "floor_one_demension")
            return UIImageView(image: image)
        }()
        
        let groupSection = groupInformationSection(group: group)
        
        view.addSubview(titleBar)
        view.addSubview(floorPlan)
        view.addSubview(groupSection)
        
        titleBar.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.left.equalToSuperview()
        }
        
        floorPlan.snp.makeConstraints {
            $0.width.height.equalTo(270)
            $0.top.equalTo(titleBar.snp.bottom).inset(-10)
            $0.centerX.equalToSuperview()
        }
        
        groupSection.snp.makeConstraints {
            $0.top.equalTo(floorPlan.snp.bottom).inset(-30)
            $0.left.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(410)
        }
        
    }
    
    func titleBar(title: String) -> UIView {
        let frame = UIView()
        frame.backgroundColor = .clear
        
        titleLabel.text = title
        titleLabel.font = .systemFont(ofSize: 20,
                                      weight: .semibold)
        
        let menuButton: UIButton = {
            let button = UIButton()
            let image = UIImage(named: "menu_bar")
            button.setImage(image,
                            for: .normal)
            
            button.addTarget(self,
                             action: #selector(presentMenu),
                             for: .touchUpInside)
            return button
        }()
        
        let gearButton: UIButton = {
            let button = UIButton()
            let image = UIImage(named: "gear")
            button.setImage(image,
                            for: .normal)
            
            button.addTarget(self,
                             action: #selector(presentSetting),
                             for: .touchUpInside)
            return button
        }()
        
        frame.addSubview(titleLabel)
        frame.addSubview(menuButton)
        frame.addSubview(gearButton)
        
        frame.snp.makeConstraints {
            $0.height.equalTo(52)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        menuButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().inset(24)
        }
        
        gearButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().inset(24)
        }
        
        return frame
    }
    
    func groupInformationSection(group: Group) -> UIView {
        let frame = UIView()
        frame.backgroundColor = .white
        frame.layer.cornerRadius = 20
        
        groupNameLabel.text = group.name
        groupNameLabel.font = .systemFont(ofSize: 20,
                                          weight: .semibold)
        
        let roomTypeLabel: UILabel = {
            let label = UILabel()
            label.text = group.roomType
            label.textColor = .mcGrey300
            label.font = .systemFont(ofSize: 14)
            
            return label
        }()
        
        let roomsLabel: UILabel = {
            let label = UILabel()
            label.text = group.rooms
            label.textColor = .mcGrey400
            label.font = .systemFont(ofSize: 14)
            return label
        }()
        
        let divider = UIView()
        divider.backgroundColor = .black
        
        let groupMemberSection = groupMemberSection(members: group.members)
        
        let completeRateTextLabel: UILabel = {
            let label = UILabel()
            label.text = "평균 완수율"
            label.font = .systemFont(ofSize: 16,
                                     weight: .medium)
            return label
        }()
        
        let completeRateLabel: UILabel = {
            let label = UILabel()
            label.text = "\(Int(group.completeRate * 100))%"
            label.font = .systemFont(ofSize: 16)
            label.textColor = .mcGrey800
            return label
        }()
        
        let completeProgressView: UIProgressView = {
            let progressView = UIProgressView()
            progressView.tintColor = .mcMainGreen
            progressView.setProgress(Float(group.completeRate), animated: true)
            return progressView
        }()
        
        let groupInviteCodeTextLabel: UILabel = {
            let label = UILabel()
            label.text = "그룹 초대 코드"
            label.font = .systemFont(ofSize: 16,
                                     weight: .medium)

            return label
        }()
        
        let groupInviteCodeButton: UIButton = {
            let button = UIButton()
            button.setTitle(group.inviteCode,
                            for: .normal)
            button.addTarget(self,
                             action: #selector(copyInviteCode),
                             for: .touchUpInside)
            return button
        }()
           
        frame.addSubview(groupNameLabel)
        frame.addSubview(roomTypeLabel)
        frame.addSubview(roomsLabel)
        frame.addSubview(divider)
        frame.addSubview(groupMemberSection)
        
        frame.addSubview(completeRateTextLabel)
        frame.addSubview(completeRateLabel)
        frame.addSubview(completeProgressView)
        
        frame.addSubview(groupInviteCodeTextLabel)
        frame.addSubview(groupInviteCodeButton)
        
        groupNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(26)
            $0.left.equalToSuperview().inset(24)
        }
        
        roomTypeLabel.snp.makeConstraints {
            $0.centerY.equalTo(groupNameLabel)
            $0.right.equalTo(roomsLabel.snp.left).inset(-4)
        }
        
        roomsLabel.snp.makeConstraints {
            $0.centerY.equalTo(groupNameLabel)
            $0.right.equalToSuperview().inset(24)
        }
        
        divider.snp.makeConstraints {
            $0.top.equalTo(groupNameLabel.snp.bottom).inset(-12)
            $0.left.right.equalToSuperview().inset(24)
            $0.height.equalTo(1)
        }
        
        groupMemberSection.snp.makeConstraints {
            $0.top.equalTo(divider.snp.bottom).inset(-24)
            $0.left.equalToSuperview().inset(24)
            $0.height.equalTo(78)
        }
        
        completeRateTextLabel.snp.makeConstraints {
            $0.top.equalTo(groupMemberSection.snp.bottom).inset(-22)
            $0.left.equalToSuperview().inset(24)
        }
        
        completeRateLabel.snp.makeConstraints {
            $0.top.equalTo(completeRateTextLabel)
            $0.right.equalToSuperview().inset(24)
        }
        
        completeProgressView.snp.makeConstraints {
            $0.top.equalTo(completeRateTextLabel.snp.bottom).inset(-20)
            $0.left.right.equalToSuperview().inset(24)
            $0.height.equalTo(10)
        }
        
        groupInviteCodeTextLabel.snp.makeConstraints {
            $0.top.equalTo(completeProgressView.snp.bottom).inset(-30)
            $0.left.equalToSuperview().inset(24)
        }
        
        groupInviteCodeButton.snp.makeConstraints {
            $0.top.equalTo(groupInviteCodeButton.snp.top)
            $0.right.equalToSuperview().inset(24)
        }
        
        return frame
    }
    
    func groupMemberSection(members: [Member]) -> UIView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 12
        
        members.forEach { member in
            
            let memberCell = groupMemberCell(member: member)
            
            stackView.addArrangedSubview(memberCell)
            
            memberCell.snp.makeConstraints {
                $0.width.equalTo(50)
                $0.height.equalTo(78)
            }
        }
        
        return stackView
    }
    
    func groupMemberCell(member: Member) -> UIView {
        let frame = UIView()
        
        let memberImageView: UIImageView = {
            let imageView = UIImageView(image: member.profileImage)
            imageView.frame = .init(origin: .zero, size: .init(width: 50, height: 50))
            imageView.backgroundColor = .mcGrey300
            imageView.layer.cornerRadius = imageView.frame.width / 2
            imageView.clipsToBounds = true
            
            return imageView
        }()
        
        let memberNameLabel: UILabel = {
            let label = UILabel()
            label.text = member.name
            label.font = .systemFont(ofSize: 12)
            return label
        }()
        
        frame.addSubview(memberImageView)
        frame.addSubview(memberNameLabel)
        
        memberImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.width.height.equalTo(50)
        }
        
        memberNameLabel.snp.makeConstraints {
            $0.top.equalTo(memberImageView.snp.bottom).inset(-4)
            $0.centerX.equalTo(memberImageView.snp.centerX)
        }
        
        return frame
    }
    
    
    @objc func presentMenu() {
        print("메뉴 등장")
    }
    
    @objc func presentSetting() {
        let actionSheet = UIAlertController()
        let deleteGroup = UIAlertAction(title: "그룹 삭제",
                                        style: .destructive) { _ in
            print("delete Group")
            let alert = UIAlertController(title: "그룹을 삭제하시겠습니까?",
                                          message: nil,
                                          preferredStyle: .alert)
            
            let delete = UIAlertAction(title: "삭제",
                                       style: .destructive)
            let cancel = UIAlertAction(title: "취소",
                                       style: .cancel)
            
            alert.addAction(delete)
            alert.addAction(cancel)
            self.present(alert, animated: true)
        }
        let settingOfGroupMember = UIAlertAction(title: "그룹원 설정",
                                                 style: .default) { _ in
            print("setting group member")
            self.navigateToGroupSettingView()
        }
        
        let editGroupName = UIAlertAction(title: "그룹 이름 수정",
                                          style: .default) { _ in
            
            let textFieldAlert = UIAlertController(title: "그룹 이름 변경",
                                                   message: "변경할 그룹 이름을 작성해주세요.",
                                                   preferredStyle: .alert)
            textFieldAlert.addTextField() { textField in
                textField.placeholder = "그룹 이름을 작성해주세요(ex. 마춰 사랑해)"
            }
            
            let confirm = UIAlertAction(title: "확인",
                                        style: .default) { _ in
                guard let textField = textFieldAlert.textFields?.first,
                      let changedName = textField.text,
                      !changedName.isEmpty
                else { return }
                
                
                self.updateGroupName(changedName: changedName, group: group)
            }
            
            let cancel = UIAlertAction(title: "취소",
                                       style: .cancel)
            
            
            textFieldAlert.addAction(confirm)
            textFieldAlert.addAction(cancel)
            
            self.present(textFieldAlert, animated: true)
        }
        
        let editFloorPlanName = UIAlertAction(title: "평면도 이름 수정",
                                              style: .default) { _ in
            
            let textFieldAlert = UIAlertController(title: "평면도 이름 변경",
                                                   message: "변경할 평면도 이름을 작성해주세요.",
                                                   preferredStyle: .alert)
            textFieldAlert.addTextField() { textField in
                textField.placeholder = "평면도 이름을 작성해주세요(ex. 우리집 평면도)"
            }
            
            let confirm = UIAlertAction(title: "확인",
                                        style: .default) { _ in
                guard let textField = textFieldAlert.textFields?.first,
                      let changedName = textField.text,
                      !changedName.isEmpty
                else { return }
                // change floorPlanName 
            }
            
            let cancel = UIAlertAction(title: "취소",
                                       style: .cancel)
            
            
            textFieldAlert.addAction(confirm)
            textFieldAlert.addAction(cancel)
            
            self.present(textFieldAlert, animated: true)
        }
        
        let cancel = UIAlertAction(title: "취소",
                                   style: .cancel)

        actionSheet.addAction(deleteGroup)
        actionSheet.addAction(settingOfGroupMember)
        actionSheet.addAction(editGroupName)
        actionSheet.addAction(editFloorPlanName)
        actionSheet.addAction(cancel)
        
        self.present(actionSheet, animated: true)
    }
    
    func navigateToGroupSettingView() {
        self.navigationController?.pushViewController(GroupMemberSettingViewController(),
                                                      animated: true)
    }
    
    func updateGroupName(changedName: String,
                         group: Group) {
        groupNameLabel.text = changedName
        titleLabel.text = changedName
//        group.name = changedName
        // update group data
    }
    
    @objc func copyInviteCode() {
        print("copy invite code")
    }
}
