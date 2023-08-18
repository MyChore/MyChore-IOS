//
//  RepeatEndViewController.swift
//  MyChore
//
//  Created by 경유진 on 2023/08/07.
//

import UIKit

import SnapKit

class RepeatEndViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        setConstraints()
    }
    
    lazy var infiniteView: UIView = {
        let infiniteView = UIView()
        infiniteView.backgroundColor = .white
        return infiniteView
    }()
    
    lazy var infiniteLabel: UILabel = {
        let infiniteLabel = UILabel()
        infiniteLabel.text = "무한 반복"
        infiniteLabel.font = UIFont.systemFont(ofSize: 18)
        return infiniteLabel
    }()
    
    lazy var infiniteSwitch: UISwitch = {
        let infiniteSwitch = UISwitch()
        infiniteSwitch.tintColor = UIColor.mcMainGreen
        infiniteSwitch.addTarget(self, action: #selector(switchEvent(sender:)), for: .valueChanged)
        return infiniteSwitch
    }()
    
    @objc func switchEvent(sender: UISwitch) {
        if sender.isOn {
            endDateView.alpha = 0
        }
        else {
            endDateView.alpha = 1
        }
    }
    
    lazy var lineView: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = UIColor.mcGrey300
        return lineView
    }()
    
    lazy var endDateView: UIView = {
        let endDateView = UIView()
        endDateView.backgroundColor = .white
        return endDateView
    }()
    
    lazy var endDateLabel: UILabel = {
        let endDateLabel = UILabel()
        endDateLabel.text = "반복 종료 날짜"
        endDateLabel.font = UIFont.systemFont(ofSize: 18)
        return endDateLabel
    }()
    
    lazy var endDatePicker: UIDatePicker = {
        let endDatePicker = UIDatePicker()
        endDatePicker.preferredDatePickerStyle = .compact
        endDatePicker.locale = Locale(identifier: "ko-KR")
        endDatePicker.datePickerMode = .date
        endDatePicker.tintColor = UIColor.mcMainGreen
        return endDatePicker
    }()
    
    func setUpView() {
        view.addSubview(infiniteView)
        infiniteView.addSubview(infiniteLabel)
        infiniteView.addSubview(infiniteSwitch)
        view.addSubview(lineView)
        view.addSubview(endDateView)
        endDateView.addSubview(endDateLabel)
        endDateView.addSubview(endDatePicker)
    }
    
    func setConstraints() {
        infiniteView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(58)
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
            make.height.equalTo(32)
        }
        infiniteLabel.snp.makeConstraints { make in
            make.centerY.equalTo(infiniteView.snp.centerY)
            make.left.equalToSuperview().offset(3)
        }
        infiniteSwitch.snp.makeConstraints { make in
            make.centerY.equalTo(infiniteLabel.snp.centerY)
            make.right.equalToSuperview().offset(-3)
        }
        lineView.snp.makeConstraints { make in
            make.height.equalTo(0.5)
            make.top.equalTo(infiniteView.snp.bottom).offset(6)
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
        }
        endDateView.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(12)
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
            make.height.equalTo(32)
        }
        endDateLabel.snp.makeConstraints { make in
            make.centerY.equalTo(endDateView.snp.centerY)
            make.left.equalToSuperview().offset(3)
        }
        endDatePicker.snp.makeConstraints { make in
            make.centerY.equalTo(endDateLabel.snp.centerY)
            make.right.equalToSuperview().offset(-3)
        }
    }
}

/*
import SwiftUI

struct ViewControllerRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = RepeatEndViewController //뷰 컨트롤러 이름
    
    func makeUIViewController(context: Context) -> RepeatEndViewController {
            return RepeatEndViewController() // 뷰컨트롤러 이름
        }

        func updateUIViewController(_ uiViewController: RepeatEndViewController, context: Context) {
        }
}

@available(iOS 16.0.0, *)
struct ViewPreview: PreviewProvider {
    static var previews: some View {
            ViewControllerRepresentable()
    }
}
*/
