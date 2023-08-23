//
//  ChoreAddMainViewController.swift
//  MyChore
//
//  Created by 경유진 on 2023/07/28.
//

import UIKit

import SnapKit

protocol SendDelegate: AnyObject {
    func sendManager(manager: String)
    func sendFurniture(furniture: String)
}

class ChoreAddMainViewController: UIViewController, SendDelegate {
    
    func sendFurniture(furniture: String) {
        self.furnitureSelectedLabel.text = furniture
    }
    
    func sendManager(manager: String) {
        self.managerSelectedLabel.text = manager
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        ChoreAddViewModel.shared.getGroupInfo()
        initNavigation()
        setUpView()
        setConstraints()
        setRoomButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        ChoreAddViewModel.shared.getGroupInfo()
    }
    
    // 네비게이션바
    func initNavigation() {
        
        let titleLabel = UILabel()
        titleLabel.text = "집안일 추가"
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        
        let doneButton = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(sendData))
        
        self.navigationItem.titleView = titleLabel
        self.navigationItem.rightBarButtonItem = doneButton
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.mcMainGreen
    }
    
    @objc func sendData() {
        print("post")
        viewDidLoad()
        alert()
        choreTextField.text = ""
        furnitureSelectedLabel.text = "지정안함"
        managerSelectedLabel.text = "지정안함"
        
//        ChoreAddViewModel.shared.userId =
//        ChoreAddViewModel.shared.groupId =
//        ChoreAddViewModel.shared.roomFurnitureId = furnitureSelectedLabel.text
//        ChoreAddViewModel.shared.name = choreTextField.text
//        ChoreAddViewModel.shared.notiTime = alarmTimePicker.
//        ChoreAddViewModel.shared.room = chore
//
//        ChoreAddViewModel.shared.isAcceptNoti = alarmSwitch.isOn
//        ChoreAddViewModel.shared.
    }
    func alert() {
        let sheet = UIAlertController(title: "추가 완료", message: "집안일이 추가되었습니다", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default)
        sheet.addAction(okAction)
        present(sheet, animated: false, completion: nil)
    }
    
    // Mark: - Views 정의
    lazy var choreNameLabel: UILabel = {
        let choreNameLabel = UILabel()
        choreNameLabel.text = "집안일 이름"
        choreNameLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        choreNameLabel.textColor = UIColor.mcGrey800
        return choreNameLabel
    }()
    
    lazy var choreTextField: UITextField = {
        let choreTextField = UITextField()
        //choreTextField.placeholder = "입력하세요"
        choreTextField.tintColor = UIColor.mcSubGreen200
        choreTextField.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        choreTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        return choreTextField
    }()
    
    lazy var textUnderLineView: UIView = {
        let textUnderLineView = UIView()
        textUnderLineView.backgroundColor = UIColor.mcSubGreen400
        return textUnderLineView
    }()
    
    lazy var firstLine: UIView = {
        let firstLine = UIView()
        firstLine.backgroundColor = UIColor.mcGrey100
        return firstLine
    }()
    
    lazy var placeIconView: UIImageView = {
        let placeIconView = UIImageView()
        placeIconView.image = UIImage(named: "icon_place")
        return placeIconView
    }()
    
    lazy var placeLabel: UILabel = {
        let placeLabel = UILabel()
        placeLabel.text = "장소"
        placeLabel.font = UIFont.systemFont(ofSize: 20)
        return placeLabel
    }()
    
    lazy var livingRoomButton: UIButton = {
        let livingRoomButton = UIButton()
        livingRoomButton.backgroundColor = UIColor.mcGrey200
        livingRoomButton.layer.cornerRadius = 10.0
        
        livingRoomButton.setTitle("거실", for: .normal)
        livingRoomButton.setTitleColor(UIColor.mcGrey800, for: .normal)
        
        livingRoomButton.addTarget(self, action: #selector(btnClicked), for: .touchUpInside)
        livingRoomButton.snp.makeConstraints { make in
            make.height.equalTo(38)
            make.width.equalTo(68)
        }
        return livingRoomButton
    }()
    
    lazy var roomBtnStackView: UIStackView = {
        let roomBtnStackView = UIStackView()
        roomBtnStackView.alignment = .fill
        roomBtnStackView.spacing = 10
        roomBtnStackView.addArrangedSubview(livingRoomButton)
        roomBtnStackView.addArrangedSubview(room1Button)
        roomBtnStackView.addArrangedSubview(room2Button)
        return roomBtnStackView
    }()
    
    lazy var room1Button: UIButton = {
        let room1Button = UIButton()
        room1Button.backgroundColor = UIColor.mcGrey200
        room1Button.layer.cornerRadius = 10.0
        
        room1Button.setTitle("방1", for: .normal)
        room1Button.setTitleColor(UIColor.mcGrey800, for: .normal)
        room1Button.addTarget(self, action: #selector(btnClicked), for: .touchUpInside)
        
        room1Button.snp.makeConstraints { make in
            make.height.equalTo(38)
            make.width.equalTo(68)
        }
        return room1Button
    }()
    
    lazy var room2Button: UIButton = {
        let room2Button = UIButton()
        room2Button.backgroundColor = UIColor.mcGrey200
        room2Button.layer.cornerRadius = 10.0
        
        room2Button.setTitle("방2", for: .normal)
        room2Button.setTitleColor(UIColor.mcGrey800, for: .normal)
        room2Button.addTarget(self, action: #selector(btnClicked), for: .touchUpInside)
        room2Button.snp.makeConstraints { make in
            make.height.equalTo(38)
            make.width.equalTo(68)
        }
        return room2Button
    }()
    
    lazy var room3Button: UIButton = {
        let room3Button = UIButton()
        room3Button.backgroundColor = UIColor.mcGrey200
        room3Button.layer.cornerRadius = 10.0
        
        room3Button.setTitle("방3", for: .normal)
        room3Button.setTitleColor(UIColor.mcGrey800, for: .normal)
        room3Button.addTarget(self, action: #selector(btnClicked), for: .touchUpInside)
        return room3Button
    }()
    
    var roomData: [RoomList] = ChoreAddViewModel.shared.room
    
    func setRoomButton() {
        for title in roomData {
            let button = UIButton(type: .system)
            button.setTitle(title.roomTypeName, for: .normal)
            button.addTarget(self, action: #selector(btnClicked), for: .touchUpInside)
            self.roomBtnStackView.addArrangedSubview(button)
        }
    }
    lazy var btnArray: [UIButton] = [livingRoomButton, room1Button, room2Button, room3Button]
    
    var selectedRoom: String? = ""
    @objc func btnClicked(_ sender: UIButton) {
        for Btn in btnArray {
            if Btn == sender {
                // 만약 현재 버튼이 이 함수를 호출한 버튼이라면
                Btn.isSelected = true
                Btn.backgroundColor = UIColor.mcSubGreen100
                Btn.setTitleColor(UIColor.mcMainGreen, for: .normal)
                
            } else {
                // 이 함수를 호출한 버튼이 아니라면
                Btn.isSelected = false
                Btn.backgroundColor = UIColor.mcGrey200
                Btn.setTitleColor(UIColor.mcGrey800, for: .normal)
            }
        }
    }

    lazy var secondLine: UIView = {
        let secondLine = UIView()
        secondLine.backgroundColor = UIColor.mcGrey100
        return secondLine
    }()
    
    lazy var furnitureIconView: UIImageView = {
        let furnitureIconView = UIImageView()
        furnitureIconView.image = UIImage(named: "icon_furniture")
        return furnitureIconView
    }()
    
    lazy var furnitureLabel: UILabel = {
        let furnitureLabel = UILabel()
        furnitureLabel.text = "가구"
        furnitureLabel.font = UIFont.systemFont(ofSize: 20)
        return furnitureLabel
    }()
    
    lazy var furnitureSelectedLabel: UILabel = {
        let furnitureSelectedLabel = UILabel()
        furnitureSelectedLabel.text = "지정안함"
        furnitureSelectedLabel.font = UIFont.systemFont(ofSize: 16)
        return furnitureSelectedLabel
    }()
    
    lazy var furnitureNextBtn: UIButton = {
        let furnitureNextBtn = UIButton()
        furnitureNextBtn.setImage(UIImage(named: "icon_mininext"), for: .normal)
        furnitureNextBtn.addTarget(self, action: #selector(furnitureSelect), for: .touchDown)
        return furnitureNextBtn
    }()
    
    @objc private func furnitureSelect() {
        let furnitureSelectVC = FurnitureSelectViewController()
        furnitureSelectVC.delegate = self
        self.navigationController?.pushViewController(furnitureSelectVC, animated: true)
    }
    
    lazy var thirdLine: UIView = {
        let thirdLine = UIView()
        thirdLine.backgroundColor = UIColor.mcGrey100
        return thirdLine
    }()
    
    lazy var dateIconView: UIImageView = {
        let dateIconView = UIImageView()
        dateIconView.image = UIImage(named: "icon_date")
        return dateIconView
    }()
    
    lazy var dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.text = "날짜"
        dateLabel.font = UIFont.systemFont(ofSize: 20)
        return dateLabel
    }()
    
    lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .compact
        datePicker.locale = Locale(identifier: "ko-KR")
        datePicker.datePickerMode = .date
        //datePicker.Color = UIColor.mcSubGreen100
        datePicker.tintColor = UIColor.mcMainGreen
        return datePicker
    }()
    
    lazy var fourthLine: UIView = {
        let fourthLine = UIView()
        fourthLine.backgroundColor = UIColor.mcGrey100
        return fourthLine
    }()
    
    lazy var alarmIconView: UIImageView = {
        let alarmIconView = UIImageView()
        alarmIconView.image = UIImage(named: "icon_alarm")
        return alarmIconView
    }()
    
    lazy var alarmLabel: UILabel = {
        let alarmLabel = UILabel()
        alarmLabel.text = "알림"
        alarmLabel.font = UIFont.systemFont(ofSize: 20)
        return alarmLabel
    }()
    
    lazy var alarmTimePicker: UIDatePicker = {
        let alarmTimePicker = UIDatePicker()
        alarmTimePicker.preferredDatePickerStyle = .compact
        alarmTimePicker.datePickerMode = .time
        alarmTimePicker.locale = Locale(identifier: "en_US")
        alarmTimePicker.tintColor = UIColor.mcMainGreen
        return alarmTimePicker
    }()
    
    lazy var alarmSwitch: UISwitch = {
        let alarmSwitch = UISwitch()
        alarmSwitch.onTintColor = UIColor.mcMainGreen
        alarmSwitch.tintColor = UIColor.mcMainGreen
        alarmSwitch.isOn = true
        alarmSwitch.addTarget(self, action: #selector(alarmSwitchEvent(sender:)), for: .valueChanged)
        return alarmSwitch
    }()
    
    @objc func alarmSwitchEvent(sender: UISwitch) {
        if sender.isOn {
            alarmTimePicker.alpha = 1
        }
        else {
            alarmTimePicker.alpha = 0
        }
    }
    
    lazy var fifthLine: UIView = {
        let fifthLine = UIView()
        fifthLine.backgroundColor = UIColor.mcGrey100
        return fifthLine
    }()
    
    lazy var repeatIconView: UIImageView = {
        let repeatIconView = UIImageView()
        repeatIconView.image = UIImage(named: "icon_repeat")
        return repeatIconView
    }()
    
    lazy var repeatLabel: UILabel = {
        let repeatLabel = UILabel()
        repeatLabel.text = "반복"
        repeatLabel.font = UIFont.systemFont(ofSize: 20)
        return repeatLabel
    }()
    
    lazy var repeatSelectedLabel: UILabel = {
        let repeatSelectedLabel = UILabel()
        repeatSelectedLabel.text = "지정안함"
        repeatSelectedLabel.font = UIFont.systemFont(ofSize: 16)
        return repeatSelectedLabel
    }()
    
    lazy var repeatNextBtn: UIButton = {
        let repeatNextBtn = UIButton()
        repeatNextBtn.setImage(UIImage(named: "icon_mininext"), for: .normal)
        repeatNextBtn.addTarget(self, action: #selector(repeatSelect), for: .touchDown)
        return repeatNextBtn
    }()
    
    @objc private func repeatSelect() {
        let repeatSelectVC = RepeatSelectViewController()
        self.navigationController?.pushViewController(repeatSelectVC, animated: true)
    }
    
    lazy var sixthLine: UIView = {
        let sixthLine = UIView()
        sixthLine.backgroundColor = UIColor.mcGrey100
        return sixthLine
    }()
    
    lazy var managerIconView: UIImageView = {
        let managerIconView = UIImageView()
        managerIconView.image = UIImage(named: "icon_manager")
        return managerIconView
    }()
    
    lazy var managerLabel: UILabel = {
        let managerLabel = UILabel()
        managerLabel.text = "담당자"
        managerLabel.font = UIFont.systemFont(ofSize: 20)
        return managerLabel
    }()
    
    lazy var managerSelectedLabel: UILabel = {
        let managerSelectedLabel = UILabel()
        managerSelectedLabel.text = "지정안함"
        managerSelectedLabel.font = UIFont.systemFont(ofSize: 16)
        return managerSelectedLabel
    }()
    
    lazy var managerNextBtn: UIButton = {
        let managerNextBtn = UIButton()
        managerNextBtn.setImage(UIImage(named: "icon_mininext"), for: .normal)
        managerNextBtn.addTarget(self, action: #selector(managerSelect), for: .touchDown)
        return managerNextBtn
    }()
    
    @objc private func managerSelect() {
        let managerSelectVC = ManagerSelectViewController()
        managerSelectVC.delegate = self
        self.navigationController?.pushViewController(managerSelectVC, animated: true)
    }
    
    lazy var seventhLine: UIView = {
        let seventhLine = UIView()
        seventhLine.backgroundColor = UIColor.mcGrey100
        return seventhLine
    }()
    
    // Mark: - view 요소 추가 함수
    func setUpView() {
        view.addSubview(choreNameLabel)
        view.addSubview(choreTextField)
        view.addSubview(textUnderLineView)
        view.addSubview(firstLine)
        view.addSubview(placeIconView)
        view.addSubview(placeLabel)
//        view.addSubview(livingRoomButton)
//        view.addSubview(room1Button)
//        view.addSubview(room2Button)
//        view.addSubview(room3Button)
        view.addSubview(roomBtnStackView)
        view.addSubview(secondLine)
        view.addSubview(furnitureIconView)
        view.addSubview(furnitureLabel)
        view.addSubview(furnitureSelectedLabel)
        view.addSubview(furnitureNextBtn)
        view.addSubview(thirdLine)
        view.addSubview(dateIconView)
        view.addSubview(dateLabel)
        view.addSubview(datePicker)
        view.addSubview(fourthLine)
        view.addSubview(alarmIconView)
        view.addSubview(alarmLabel)
        view.addSubview(alarmTimePicker)
        view.addSubview(alarmSwitch)
        view.addSubview(fifthLine)
        view.addSubview(repeatIconView)
        view.addSubview(repeatLabel)
        view.addSubview(repeatSelectedLabel)
        view.addSubview(repeatNextBtn)
        view.addSubview(sixthLine)
        view.addSubview(managerIconView)
        view.addSubview(managerLabel)
        view.addSubview(managerSelectedLabel)
        view.addSubview(managerNextBtn)
        view.addSubview(seventhLine)
    }
    
    // Mark: - constraints 설정 함수
    func setConstraints() {
        choreNameLabel.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(20)
            make.left.equalTo(self.view.safeAreaLayoutGuide).offset(24)
        }
        choreTextField.snp.makeConstraints { make in
            make.top.equalTo(choreNameLabel.snp.bottom).offset(14)
            make.left.equalTo(self.view.safeAreaLayoutGuide).offset(26)
            make.right.equalTo(self.view.safeAreaLayoutGuide).offset(-23)
        }
        textUnderLineView.snp.makeConstraints { make in
            make.height.equalTo(2)
            make.top.equalTo(choreTextField.snp.bottom).offset(6)
            make.left.equalTo(self.view.safeAreaLayoutGuide).offset(25)
            make.right.equalTo(self.view.safeAreaLayoutGuide).offset(-23)
        }
        firstLine.snp.makeConstraints { make in
            make.height.equalTo(2)
            make.top.equalTo(textUnderLineView.snp.bottom).offset(16)
            make.left.equalTo(self.view.safeAreaLayoutGuide).offset(24)
            make.right.equalTo(self.view.safeAreaLayoutGuide).offset(-24)
        }
        placeIconView.snp.makeConstraints { make in
            make.height.width.equalTo(32)
            make.top.equalTo(firstLine.snp.bottom).offset(16)
            make.left.equalTo(self.view.safeAreaLayoutGuide).offset(16)
        }
        placeLabel.snp.makeConstraints { make in
            make.centerY.equalTo(placeIconView.snp.centerY)
            make.left.equalTo(placeIconView.snp.right).offset(8)
        }
        roomBtnStackView.snp.makeConstraints { make in
            make.top.equalTo(placeIconView.snp.bottom).offset(11)
            make.height.equalTo(38)
            make.left.equalTo(self.view.safeAreaLayoutGuide).offset(24)
        }
        secondLine.snp.makeConstraints { make in
            make.height.equalTo(2)
            make.top.equalTo(roomBtnStackView.snp.bottom).offset(14)
            make.left.equalTo(self.view.safeAreaLayoutGuide).offset(24)
            make.right.equalTo(self.view.safeAreaLayoutGuide).offset(-24)
        }
        furnitureIconView.snp.makeConstraints { make in
            make.height.width.equalTo(32)
            make.top.equalTo(secondLine.snp.bottom).offset(16)
            make.left.equalTo(self.view.safeAreaLayoutGuide).offset(16)
        }
        furnitureLabel.snp.makeConstraints { make in
            make.centerY.equalTo(furnitureIconView.snp.centerY)
            make.left.equalTo(furnitureIconView.snp.right).offset(8)
        }
        furnitureSelectedLabel.snp.makeConstraints { make in
            make.centerY.equalTo(furnitureIconView.snp.centerY)
            make.right.equalTo(furnitureNextBtn.snp.left)
        }
        furnitureNextBtn.snp.makeConstraints { make in
            make.centerY.equalTo(furnitureIconView.snp.centerY)
            make.right.equalTo(self.view.safeAreaLayoutGuide).offset(-19)
        }
        thirdLine.snp.makeConstraints { make in
            make.height.equalTo(2)
            make.top.equalTo(furnitureIconView.snp.bottom).offset(14)
            make.left.equalTo(self.view.safeAreaLayoutGuide).offset(24)
            make.right.equalTo(self.view.safeAreaLayoutGuide).offset(-24)
        }
        dateIconView.snp.makeConstraints { make in
            make.height.width.equalTo(32)
            make.top.equalTo(thirdLine.snp.bottom).offset(16)
            make.left.equalTo(self.view.safeAreaLayoutGuide).offset(16)
        }
        dateLabel.snp.makeConstraints { make in
            make.centerY.equalTo(dateIconView.snp.centerY)
            make.left.equalTo(dateIconView.snp.right).offset(8)
        }
        datePicker.snp.makeConstraints { make in
            make.centerY.equalTo(dateIconView.snp.centerY)
            make.right.equalTo(self.view.safeAreaLayoutGuide).offset(-24)
        }
        fourthLine.snp.makeConstraints { make in
            make.height.equalTo(2)
            make.top.equalTo(dateIconView.snp.bottom).offset(14)
            make.left.equalTo(self.view.safeAreaLayoutGuide).offset(24)
            make.right.equalTo(self.view.safeAreaLayoutGuide).offset(-24)
        }
        alarmIconView.snp.makeConstraints { make in
            make.height.width.equalTo(32)
            make.top.equalTo(fourthLine.snp.bottom).offset(16)
            make.left.equalTo(self.view.safeAreaLayoutGuide).offset(16)
        }
        alarmLabel.snp.makeConstraints { make in
            make.centerY.equalTo(alarmIconView.snp.centerY)
            make.left.equalTo(alarmIconView.snp.right).offset(8)
        }
        alarmTimePicker.snp.makeConstraints { make in
            make.centerY.equalTo(alarmIconView.snp.centerY)
            make.right.equalTo(alarmSwitch.snp.left).offset(-16)
        }
        alarmSwitch.snp.makeConstraints { make in
            make.centerY.equalTo(alarmIconView.snp.centerY)
            make.right.equalTo(self.view.safeAreaLayoutGuide).offset(-24)
        }
        fifthLine.snp.makeConstraints { make in
            make.height.equalTo(2)
            make.top.equalTo(alarmIconView.snp.bottom).offset(14)
            make.left.equalTo(self.view.safeAreaLayoutGuide).offset(24)
            make.right.equalTo(self.view.safeAreaLayoutGuide).offset(-24)
        }
        repeatIconView.snp.makeConstraints { make in
            make.height.width.equalTo(32)
            make.top.equalTo(fifthLine.snp.bottom).offset(16)
            make.left.equalTo(self.view.safeAreaLayoutGuide).offset(16)
        }
        repeatLabel.snp.makeConstraints { make in
            make.centerY.equalTo(repeatIconView.snp.centerY)
            make.left.equalTo(repeatIconView.snp.right).offset(8)
        }
        repeatSelectedLabel.snp.makeConstraints { make in
            make.centerY.equalTo(repeatIconView.snp.centerY)
            make.right.equalTo(repeatNextBtn.snp.left)
        }
        repeatNextBtn.snp.makeConstraints { make in
            make.centerY.equalTo(repeatIconView.snp.centerY)
            make.right.equalTo(self.view.safeAreaLayoutGuide).offset(-19)
        }
        sixthLine.snp.makeConstraints { make in
            make.height.equalTo(2)
            make.top.equalTo(repeatIconView.snp.bottom).offset(14)
            make.left.equalTo(self.view.safeAreaLayoutGuide).offset(24)
            make.right.equalTo(self.view.safeAreaLayoutGuide).offset(-24)
        }
        managerIconView.snp.makeConstraints { make in
            make.height.width.equalTo(32)
            make.top.equalTo(sixthLine.snp.bottom).offset(16)
            make.left.equalTo(self.view.safeAreaLayoutGuide).offset(16)
        }
        managerLabel.snp.makeConstraints { make in
            make.centerY.equalTo(managerIconView.snp.centerY)
            make.left.equalTo(managerIconView.snp.right).offset(8)
        }
        managerSelectedLabel.snp.makeConstraints { make in
            make.centerY.equalTo(managerIconView.snp.centerY)
            make.right.equalTo(managerNextBtn.snp.left)
        }
        managerNextBtn.snp.makeConstraints { make in
            make.centerY.equalTo(managerIconView.snp.centerY)
            make.right.equalTo(self.view.safeAreaLayoutGuide).offset(-19)
        }
        seventhLine.snp.makeConstraints { make in
            make.height.equalTo(2)
            make.top.equalTo(managerIconView.snp.bottom).offset(14)
            make.left.equalTo(self.view.safeAreaLayoutGuide).offset(24)
            make.right.equalTo(self.view.safeAreaLayoutGuide).offset(-24)
        }
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            view.endEditing(true)
        }
        sender.cancelsTouchesInView = false
    }
}
