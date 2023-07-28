//
//  ChoreAddMainViewController.swift
//  MyChore
//
//  Created by 경유진 on 2023/07/28.
//

import UIKit

import SnapKit

class ChoreAddMainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        initNavigation()
        setUpView()
        setConstraints()
    }
    
    // 네비게이션바
    func initNavigation() {
        let backButton = UIBarButtonItem(image: UIImage(named: "icon_back"), style: .plain, target: self, action: #selector(backMainPage))
        backButton.tintColor = UIColor.mcGrey800
        
        let titleLabel = UILabel()
        titleLabel.text = "집안일 추가"
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        
        let doneButton = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(sendData))
        
        
        self.navigationItem.leftBarButtonItem = backButton
        self.navigationItem.titleView = titleLabel
        self.navigationItem.rightBarButtonItem = doneButton
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.mcMainGreen
    }
    
    @objc func backMainPage() {
        print("페이지 pop") // pop 표시
    }
    
    @objc func sendData() {
        print("페이지 pop")
    }
    
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
        choreTextField.tintColor = UIColor.mcSubGreen100
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
    
    let placeButton: UIButton = {
        let placeButton = UIButton()
        placeButton.backgroundColor = UIColor.mcGrey200
        placeButton.layer.cornerRadius = 10.0
        
        placeButton.setTitle("거실", for: .normal)
        placeButton.setTitleColor(UIColor.mcGrey800, for: .normal)
        
        return placeButton
    }()
    
    lazy var placeButton1 = placeButton
    
    lazy var secondLine: UIView = {
        let secondLine = UIView()
        secondLine.backgroundColor = UIColor.mcGrey100
        return secondLine
    }()
    
    func setUpView() {
        view.addSubview(choreNameLabel)
        view.addSubview(choreTextField)
        view.addSubview(textUnderLineView)
        view.addSubview(firstLine)
        view.addSubview(placeIconView)
        view.addSubview(placeLabel)
        view.addSubview(placeButton1)
        view.addSubview(secondLine)
    }
    
    func setConstraints() {
        choreNameLabel.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(10)
            make.left.equalTo(self.view.safeAreaLayoutGuide).offset(20)
        }
        choreTextField.snp.makeConstraints { make in
            make.top.equalTo(choreNameLabel.snp.bottom).offset(3)
            make.left.equalTo(self.view.safeAreaLayoutGuide).offset(21)
            make.right.equalTo(self.view.safeAreaLayoutGuide).offset(-21)
        }
        textUnderLineView.snp.makeConstraints { make in
            make.height.equalTo(2)
            make.top.equalTo(choreTextField.snp.bottom).offset(2)
            make.left.equalTo(self.view.safeAreaLayoutGuide).offset(21)
            make.right.equalTo(self.view.safeAreaLayoutGuide).offset(-21)
        }
        firstLine.snp.makeConstraints { make in
            make.height.equalTo(2)
            make.top.equalTo(textUnderLineView.snp.bottom).offset(18)
            make.left.equalTo(self.view.safeAreaLayoutGuide).offset(21)
            make.right.equalTo(self.view.safeAreaLayoutGuide).offset(-21)
        }
        placeIconView.snp.makeConstraints { make in
            make.height.width.equalTo(32)
            make.top.equalTo(firstLine.snp.bottom).offset(18)
            make.left.equalTo(self.view.safeAreaLayoutGuide).offset(16)
        }
        placeLabel.snp.makeConstraints { make in
            make.centerY.equalTo(placeIconView.snp.centerY)
            make.left.equalTo(placeIconView.snp.right).offset(5)
        }
        placeButton1.snp.makeConstraints { make in
            make.height.equalTo(38)
            make.width.equalTo(72)
            make.top.equalTo(placeIconView.snp.bottom).offset(5)
            make.left.equalTo(self.view.safeAreaLayoutGuide).offset(24)
        }
        secondLine.snp.makeConstraints { make in
            make.height.equalTo(2)
            make.top.equalTo(placeButton1.snp.bottom).offset(18)
            make.left.equalTo(self.view.safeAreaLayoutGuide).offset(21)
            make.right.equalTo(self.view.safeAreaLayoutGuide).offset(-21)
        }
    }
}

import SwiftUI

struct ViewControllerRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = ChoreAddMainViewController //뷰 컨트롤러 이름
    
    func makeUIViewController(context: Context) -> ChoreAddMainViewController {
            return ChoreAddMainViewController() // 뷰컨트롤러 이름
        }

        func updateUIViewController(_ uiViewController: ChoreAddMainViewController, context: Context) {
        }
}

@available(iOS 16.0.0, *)
struct ViewPreview: PreviewProvider {
    static var previews: some View {
            ViewControllerRepresentable()
    }
}

