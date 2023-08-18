//
//  RepeatPeriodViewController.swift
//  MyChore
//
//  Created by 경유진 on 2023/08/05.
//

import UIKit

import SnapKit

struct Period {
    let periodLabel: String
    let checkImage: UIImage
}

class RepeatPeriodViewController: UIViewController, UITableViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        view.addSubview(repeatPeriodTableView)
        
        repeatPeriodTableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            //make.width.equalTo(350)
            make.right.equalToSuperview().offset(-24)
            make.bottom.equalToSuperview()
        }
        
        repeatPeriodTableView.register(RepeatPeriodTableViewCell.self, forCellReuseIdentifier: RepeatPeriodTableViewCell.identifier)
        repeatPeriodTableView.delegate = self
        repeatPeriodTableView.dataSource = self
    }
    
    let period: [Period] = [Period(periodLabel: "안함", checkImage: UIImage(named: "icon_check")!),
                            Period(periodLabel: "일간", checkImage: UIImage(named: "icon_check")!),
                            Period(periodLabel: "주간", checkImage: UIImage(named: "icon_check")!),
                            Period(periodLabel: "월간", checkImage: UIImage(named: "icon_check")!)
                            ]
   
    lazy var repeatPeriodTableView: UITableView = {
        let repeatPeriodTableView = UITableView()
        //repeatPeriodTableView.separatorStyle = .none
        repeatPeriodTableView.rowHeight = 50
        return repeatPeriodTableView
    }()
    
    var selectedPeriod: String = ""
}

extension RepeatPeriodViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return period.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = repeatPeriodTableView.dequeueReusableCell(withIdentifier: RepeatPeriodTableViewCell.identifier, for: indexPath) as! RepeatPeriodTableViewCell
        cell.periodLabel.text = period[indexPath.row].periodLabel
        cell.selectionStyle = .none
        
        if cell.periodLabel.text == selectedPeriod {
            cell.checkImage.alpha = 1
        }
        else {
            cell.checkImage.alpha = 0
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPeriod = period[indexPath.row].periodLabel
        print(selectedPeriod)
        tableView.reloadData()
    }
}

class RepeatPeriodTableViewCell: UITableViewCell {
    
    static let identifier = "RepeatPeriodTableViewCell"
    
    let periodLabel = UILabel()
    let checkImage = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        checkImage.image = UIImage(named: "icon_check")
        addSubview(periodLabel)
        addSubview(checkImage)
            
        periodLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(24)
        }
        checkImage.snp.makeConstraints { make in
            make.height.width.equalTo(32)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

/*
import SwiftUI

struct ViewControllerRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = RepeatPeriodViewController //뷰 컨트롤러 이름
    
    func makeUIViewController(context: Context) -> RepeatPeriodViewController {
            return RepeatPeriodViewController() // 뷰컨트롤러 이름
        }

    func updateUIViewController(_ uiViewController: RepeatPeriodViewController, context: Context) {
    }
}

@available(iOS 16.0.0, *)
struct ViewPreview: PreviewProvider {
    static var previews: some View {
            ViewControllerRepresentable()
    }
}*/
