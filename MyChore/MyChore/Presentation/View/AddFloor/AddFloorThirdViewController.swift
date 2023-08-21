//
//  AddFloorSecondViewController.swift
//  MyChore
//
//  Created by 유상 on 2023/08/22.
//

import UIKit
import SnapKit

class AddFloorThirdViewController: UIViewController {
    
    private let titleLabel = UILabel()
    
    private let contentCollectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        
        layout.itemSize = CGSize(width: (CGFloat.screenWidth - (48+16)) / 2, height: 128)
        layout.minimumLineSpacing = 16
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
       
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        cv.register(RoomSelectCell.self, forCellWithReuseIdentifier: "cell")
        
        return cv
    }()
    
    private let nextButton = UIButton()
    
    private let backBarButton = UIBarButtonItem()
    
    private var selectedRoom: RoomKind?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setupView()
        setupConstraint()
    }
    
    private func setup() {
        backBarButton.image = UIImage(named: "back")
        backBarButton.tintColor = .black
        backBarButton.target = self
        backBarButton.action = #selector(backNavigationAction)
        
        self.navigationItem.leftBarButtonItem = backBarButton

        //myInfo Viewmodel 연결
        titleLabel.text = "님,\n집 종류를 알려주세요."
        titleLabel.font = .systemFont(ofSize: 28)
        titleLabel.numberOfLines = 0
        
        contentCollectionView.dataSource = self
        contentCollectionView.delegate = self
        
        nextButton.setTitle("다음", for: .normal)
        nextButton.backgroundColor = .mcMainGreen
        nextButton.tintColor = .white
        nextButton.layer.cornerRadius = 10
        nextButton.addTarget(self, action: #selector(nextButtonAction), for: .touchDown)
        
    }
    
    private func setupView() {
        self.view.backgroundColor = .white
        
        self.view.addSubview(titleLabel)
        self.view.addSubview(contentCollectionView)
        self.view.addSubview(nextButton)
    }
    
    private func setupConstraint() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(67)
            make.leading.equalToSuperview().offset(24)
        }
        
        contentCollectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(50)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(280)
        }
        
        nextButton.snp.makeConstraints { make in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).inset(8)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(58)
        }
    }
    
    @objc private func backNavigationAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func nextButtonAction() {
    }

}

extension AddFloorThirdViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return RoomKind.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! RoomSelectCell
        
        cell.titleLabel.text = RoomKind.allCases[indexPath.row].rawValue
        cell.contentLabel.text = RoomKind.allCases[indexPath.row].getRoomComposition()
        cell.contentImageView.image = UIImage(named: RoomKind.allCases[indexPath.row].getRoomImage())
        cell.contentView.backgroundColor = .mcGrey100
        
        if let selectedRoom = selectedRoom {
            if RoomKind.allCases[indexPath.row] == selectedRoom {
                cell.contentView.backgroundColor = UIColor(red: 0.929, green: 0.973, blue: 0.953, alpha: 1)
                cell.contentImageView.image = UIImage(named: RoomKind.allCases[indexPath.row].getRoomSelectedImage())
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedRoom = RoomKind.allCases[indexPath.row]
        collectionView.reloadData()
    }
    
    
}
