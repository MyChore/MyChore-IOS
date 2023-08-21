//
//  GroupMemberSettingViewController.swift
//  MyChore
//
//  Created by sole on 2023/08/22.
//

import UIKit
import SnapKit

class GroupMemberSettingViewController: ViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        
        let titleBar = titleBar(title: "우리집 좋아요")
        let memberList = memberList(members: members)
        view.addSubview(titleBar)
        view.addSubview(memberList)
        
        titleBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.left.right.width.equalToSuperview()
        }
        
        memberList.snp.makeConstraints {
            $0.top.equalTo(titleBar.snp.bottom).inset(-20)
            $0.left.right.equalToSuperview()
        }
        
    }
    
    func titleBar(title: String) -> UIView {
        let frame = UIView()
        frame.backgroundColor = .clear
        
        let titleLabel: UILabel = {
            let label = UILabel()
            label.text = title
            label.font = .systemFont(ofSize: 20,
                                     weight: .semibold)
            return label
        }()
        
        let backButton: UIButton = {
            let button = UIButton()
            let image = UIImage(named: "back")
            button.setImage(image,
                            for: .normal)
            
            button.addTarget(self,
                             action: #selector(popNavigation),
                             for: .touchUpInside)
            return button
        }()
        
//        let completeButton: UIButton = {
//            let button = UIButton()
//            button.setTitle("완료", for: .normal)
//            button.setTitleColor(UIColor.mcMainGreen,
//                                 for: .normal)
//
//            button.addTarget(self,
//                             action: #selector(completeEditing),
//                             for: .touchUpInside)
//            return button
//        }()
        
        frame.addSubview(titleLabel)
        frame.addSubview(backButton)
//        frame.addSubview(completeButton)
        
        frame.snp.makeConstraints {
            $0.height.equalTo(52)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        backButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().inset(24)
        }
        
//        completeButton.snp.makeConstraints {
//            $0.centerY.equalToSuperview()
//            $0.right.equalToSuperview().inset(24)
//        }
        
        return frame
    }
    
    func memberList(members: [Member]) -> UIView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        
        members.forEach { member in
            let memberCell = memberCell(member: member)
            
            stackView.addArrangedSubview(memberCell)
            
            memberCell.snp.makeConstraints {
                $0.width.equalToSuperview()
                $0.height.equalTo(63)
            }
        }
        
        
        return stackView
    }
    
    func memberCell(member: Member) -> UIView {
        let frame = UIView()
        
        let memberProfileImageView: UIImageView = {
            let image = member.profileImage
            let imageView = UIImageView(image: image)
            imageView.backgroundColor = .mcGrey500
            imageView.frame = .init(origin: .zero,
                                    size: .init(width: 50,
                                                height: 50))
            imageView.layer.cornerRadius = imageView.frame.width / 2
            imageView.clipsToBounds = true
            return imageView
        }()
        
        let memberNameLabel: UILabel = {
            let label = UILabel()
            label.text = member.name
            label.font = .systemFont(ofSize: 18,
                                     weight: .medium)
            return label
        }()
        
        let rightChevron: UIImageView = {
            let image = UIImage(named: "next")
            let imageView = UIImageView(image: image)
            return imageView
        }()
        
        let divider: UIView = {
            let view = UIView()
            view.backgroundColor = .mcGrey300
            return view
        }()
        
        
        frame.addSubview(memberProfileImageView)
        frame.addSubview(memberNameLabel)
        frame.addSubview(rightChevron)
        frame.addSubview(divider)
        
        memberProfileImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().inset(24)
        }
        
        memberNameLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalTo(memberProfileImageView.snp.right).inset(-24)
        }
        
        rightChevron.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().inset(24)
        }
        
        divider.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(24)
            $0.top.equalTo(rightChevron.snp.bottom).inset(-18)
            $0.height.equalTo(1)
        }
        
        return frame
    }
    
    
    @objc func popNavigation() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func completeEditing() {
        print("edit done")
    }
}
