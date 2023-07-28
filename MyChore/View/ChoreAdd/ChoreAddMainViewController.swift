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
   
    let sectionLineView: UIView = {
        let sectionLineView = UIView()
        sectionLineView.backgroundColor = UIColor.mcGrey100
        return sectionLineView
    }()
    
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
    
    lazy var firstLine = sectionLineView
    
    func setUpView() {
        view.addSubview(choreNameLabel)
        view.addSubview(choreTextField)
        view.addSubview(textUnderLineView)
        view.addSubview(firstLine)
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

