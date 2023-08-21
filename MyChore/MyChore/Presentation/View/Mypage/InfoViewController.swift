//
//  InfoViewController.swift
//  MyChore
//
//  Created by 유상 on 2023/08/17.
//

import UIKit
import SnapKit

class InfoViewController: UIViewController {
    private let infoList = ["이용약관", "개인정보 정책"]
    
    private let backButton = UIBarButtonItem()
    
    private let infoTableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setup()
        setupView()
        setupConstraint()
    }
    
    private func setup() {
        self.view.backgroundColor = .white
        
        self.navigationItem.title = "정보"
        
        let backImageButton = UIButton()
        backImageButton.setImage(UIImage(named: "back"), for: .normal)
        backImageButton.addTarget(self, action:  #selector(backAction), for: .touchDown)
        
        backButton.customView = backImageButton
        self.navigationItem.leftBarButtonItem = backButton
        
        
        infoTableView.dataSource = self
        infoTableView.delegate = self
        infoTableView.register(InfoCell.self, forCellReuseIdentifier: "cell")
        
        infoTableView.separatorInset.left = 35
        infoTableView.separatorInset.right = 35
    }
    
    private func setupView() {
        self.view.addSubview(infoTableView)
    }
    
    private func setupConstraint() {
        infoTableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    
    @objc private func backAction() {
        self.navigationController?.popViewController(animated: true)
    }

}

extension InfoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! InfoCell
        
        cell.setupTitle(title: infoList[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    
}
