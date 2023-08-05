//
//  ManagerSelectViewController.swift
//  MyChore
//
//  Created by 경유진 on 2023/07/31.
//

import UIKit

import SnapKit

struct M_Test {
    let peopleImg: UIImage?
    let peopleName: String
    
    static var data = [
        M_Test(peopleImg: UIImage(named: ""), peopleName: "삼공"),
        M_Test(peopleImg: UIImage(named: ""), peopleName: "삼공"),
        M_Test(peopleImg: UIImage(named: ""), peopleName: "삼공"),
        M_Test(peopleImg: UIImage(named: ""), peopleName: "삼공"),
        M_Test(peopleImg: UIImage(named: ""), peopleName: "삼공")
        ]
}

class ManagerSelectViewController: UIViewController {
    
    let testdata = M_Test.data
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        managerCollectionView.delegate = self
        managerCollectionView.dataSource = self
        managerCollectionView.register(ManagerCollectionViewCell.self, forCellWithReuseIdentifier: ManagerCollectionViewCell.identifier)
        
        initNavigation()
        view.addSubview(managerCollectionView)
        
        managerCollectionView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(20)
            make.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
        }
    }
    
    private let managerCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    func initNavigation() {
        let backButton = UIBarButtonItem(image: UIImage(named: "icon_back"), style: .plain, target: self, action: #selector(backMainPage))
        backButton.tintColor = UIColor.mcGrey800
        
        let titleLabel = UILabel()
        titleLabel.text = "그룹원"
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        
        let doneButton = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(sendData))
        
        
        self.navigationItem.leftBarButtonItem = backButton
        self.navigationItem.titleView = titleLabel
        self.navigationItem.rightBarButtonItem = doneButton
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.mcMainGreen
    }
    
    @objc func backMainPage() {
        self.navigationController?.popViewController(animated: true)
        print("페이지 pop") // pop 표시
    }
    
    @objc func sendData() {
        print("페이지 pop")
    }
}

extension ManagerSelectViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        testdata.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = managerCollectionView.dequeueReusableCell(withReuseIdentifier: ManagerCollectionViewCell.identifier, for: indexPath) as?
                    ManagerCollectionViewCell else {
                        return UICollectionViewCell()
                    }
        cell.peopleImage.image = testdata[indexPath.row].peopleImg
        cell.peopleLabel.text = testdata[indexPath.row].peopleName
        cell.backgroundColor = .mcGrey200
        return cell
    }
}

extension ManagerSelectViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = (collectionView.frame.width / 2) - 5.0
        return CGSize(width: width, height: 68)
    }
}


class ManagerCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ManagerCollectionViewCell"
    
    let peopleImage: UIImageView = {
        var peopleImage = UIImageView()
        peopleImage.backgroundColor = UIColor.mcGrey300
        peopleImage.layer.cornerRadius = 22
        return peopleImage
    }()
    
    let peopleLabel: UILabel = {
        var peopleLabel = UILabel()
        peopleLabel.font = UIFont.systemFont(ofSize: 18)
        return peopleLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpCell()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpCell()
        setConstraints()
    }
    
    func setUpCell() {
        self.addSubview(peopleImage)
        self.addSubview(peopleLabel)
        layer.cornerRadius = 10
    }
    
    func setConstraints() {
        peopleImage.snp.makeConstraints { make in
            make.width.height.equalTo(44)
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(19)
        }
        peopleLabel.snp.makeConstraints { make in
            make.left.equalTo(peopleImage.snp.right).offset(10)
            make.centerY.equalToSuperview()
        }
    }
}

import SwiftUI

struct ViewControllerRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = ManagerSelectViewController //뷰 컨트롤러 이름
    
    func makeUIViewController(context: Context) -> ManagerSelectViewController {
            return ManagerSelectViewController() // 뷰컨트롤러 이름
        }

        func updateUIViewController(_ uiViewController: ManagerSelectViewController, context: Context) {
        }
}

@available(iOS 16.0.0, *)
struct ViewPreview: PreviewProvider {
    static var previews: some View {
            ViewControllerRepresentable()
    }
}
