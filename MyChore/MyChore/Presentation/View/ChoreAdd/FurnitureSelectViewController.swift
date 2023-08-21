//
//  FurnitureSelectViewController.swift
//  MyChore
//
//  Created by 경유진 on 2023/07/31.
//

import UIKit

import SnapKit

struct F_Test {
    let furniture: String
    
    static var data = [
        F_Test(furniture: "티비"),
        F_Test(furniture: "1인용 소파"),
        F_Test(furniture: "3인용 소파"),
        F_Test(furniture: "책장")]
}

class FurnitureSelectViewController: UIViewController, UICollectionViewDelegate {
    
    let testdata = F_Test.data
    
    var selectedFurniture = ""
    var furniture: String?
    weak var delegate: SendDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        furnitureCollectionView.delegate = self
        furnitureCollectionView.dataSource = self
        furnitureCollectionView.register(FurnitureCollectionViewCell.self, forCellWithReuseIdentifier: FurnitureCollectionViewCell.identifier)
        
        initNavigation()
        view.addSubview(furnitureCollectionView)
        
        furnitureCollectionView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(20)
            make.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
        }
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        
//        ChoreAddViewModel.shared.getGroup()
//    }
    
    private let furnitureCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    func initNavigation() {
        let backButton = UIBarButtonItem(image: UIImage(named: "icon_back"), style: .plain, target: self, action: #selector(backMainPage))
        backButton.tintColor = UIColor.mcGrey800
        
        let titleLabel = UILabel()
        titleLabel.text = "가구"
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
        self.delegate?.sendFurniture(furniture: selectedFurniture)
        print("페이지 pop")
        self.navigationController?.popViewController(animated: true)
    }
}

extension FurnitureSelectViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        testdata.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = furnitureCollectionView.dequeueReusableCell(withReuseIdentifier: FurnitureCollectionViewCell.identifier, for: indexPath) as?
                    FurnitureCollectionViewCell else {
                        return UICollectionViewCell()
                    }

        cell.furnitureLabel.text = testdata[indexPath.row].furniture
        cell.backgroundColor = .mcGrey200
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedFurniture = testdata[indexPath.row].furniture
    }
    
    
}

extension FurnitureSelectViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = (collectionView.frame.width / 2) - 5.0
        return CGSize(width: width, height: 68)
    }
}

class FurnitureCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "FurnitureCollectionViewCell"
    
    let furnitureLabel: UILabel = {
        var furnitureLabel = UILabel()
        furnitureLabel.font = UIFont.systemFont(ofSize: 18)
        return furnitureLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpCell()
        setConstraints()
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected == true {
                furnitureLabel.textColor = UIColor.mcMainGreen
                backgroundColor = UIColor.mcSubGreen100
            }
            else {
                furnitureLabel.textColor = UIColor.black
                backgroundColor = UIColor.mcGrey200
            }
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpCell()
        setConstraints()
    }
    
    func setUpCell() {
        self.addSubview(furnitureLabel)
        layer.cornerRadius = 10
    }
    
    func setConstraints() {
        furnitureLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
}
