//
//  HomeViewController.swift
//  MyChore
//
//  Created by sole on 2023/08/18.
//

import UIKit
import SnapKit

struct Member {
    var name: String
    var profileImage: UIImage?
    var isSelected: Bool
}

let members: [Member] = [.init(name: "삼공", isSelected: true),
                         .init(name: "사공", isSelected: false),
                         .init(name: "오공", isSelected: false),
                         .init(name: "육공", isSelected: false),
                         .init(name: "칠공", isSelected: false)]

class HomeViewController: ViewController {
    let todoTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        todoTableView.register(TodoTableCell.self,
                               forCellReuseIdentifier: TodoTableCell.identifier)
        todoTableView.allowsSelection = false
        todoTableView.delegate = self
        todoTableView.dataSource = self
        todoTableView.rowHeight = 56
        todoTableView.separatorStyle = .none
        
        
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .mcSubGreen100
        
        let informationView = informationTopSection(groupName: "마초사랑해")
        let todoScrollView = todoScrollView(name: "삼공")
        //FIXME: 평면도로 대체해야 함.
        let floorPlanView = UIView()
        floorPlanView.backgroundColor = .mcMainGreen
        
        
        view.addSubview(informationView)
        view.addSubview(floorPlanView)
        view.addSubview(todoScrollView)
       
        
        informationView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(10)
            $0.left.right.equalToSuperview().inset(24)
        }
        
        floorPlanView.snp.makeConstraints {
            $0.height.greaterThanOrEqualTo(200)
            $0.height.lessThanOrEqualTo(200)
            $0.top.equalTo(informationView.snp.bottom)
            $0.bottom.equalTo(todoScrollView.snp.top).inset(-10)
            $0.left.equalToSuperview().inset(19)
            $0.right.equalToSuperview().inset(21)
        }
        
        todoScrollView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(61)
            $0.height.equalTo(300)
        }
        
    }
    
    //MARK: - informationTopSection
    func informationTopSection(groupName: String) -> UIView {
        let frame = UIView()
        let dateLabel = UILabel()
        dateLabel.text = Date().formatUntilDay()
        dateLabel.font = .systemFont(ofSize: 14,
                                     weight: .semibold)
        
        let groupNameLabel = UILabel()
        groupNameLabel.text = groupName
        groupNameLabel.font = .systemFont(ofSize: 22,
                                          weight: .semibold)
        
        
        let groupMemberSection = groupMemberSection(memberList: members)
        
        let completionProgressView = CircularProgressView()
        completionProgressView.setProgress(0.74)
        
        frame.addSubview(dateLabel)
        frame.addSubview(groupNameLabel)
        frame.addSubview(groupMemberSection)
        frame.addSubview(completionProgressView)
        
        dateLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.equalToSuperview()
        }
        
        groupNameLabel.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).inset(-4)
            $0.left.equalToSuperview()
        }
        
        groupMemberSection.snp.makeConstraints {
            $0.top.equalTo(groupNameLabel.snp.bottom).inset(-10)
            $0.left.equalToSuperview()
            $0.width.lessThanOrEqualTo(176)
            $0.height.equalTo(64)
            
        }
        
        completionProgressView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(19)
            $0.right.equalToSuperview()
            $0.width.height.equalTo(70)
        }
        
        
        return frame
    }
    
    //MARK: - groupMemberSection
    func groupMemberSection(memberList: [Member]) -> UIView {
        let scrollView = UIScrollView()
        
        let contentView = UIStackView()
        contentView.axis = .horizontal
        contentView.spacing = 8
        
        scrollView.addSubview(contentView)
        
        
        memberList.forEach { member in
            let memberView = groupMemberCell(member: member)
            
            contentView.addArrangedSubview(memberView)
            
            memberView.snp.makeConstraints {
                $0.width.equalTo(36)
            }
        }

        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide.snp.edges)
            $0.height.equalToSuperview()
            $0.width.greaterThanOrEqualToSuperview()
        }
        
        
        return scrollView
    }
    
    //MARK: - todoScrollView
    func todoScrollView(name: String) -> UIView {
        
        let rightChevronImageView: UIImageView = {
            let rightChevronImage = UIImage(named: "icon_next")
            return UIImageView(image: rightChevronImage)
        }()
        
        let frame = UIView()
        
        frame.layer.cornerRadius = 20
        frame.backgroundColor = .white
        
        let nameLabel = UILabel()
        nameLabel.text = name
        nameLabel.font = .systemFont(ofSize: 20,
                                     weight: .semibold)
        
        let choreLabel = UILabel()
        choreLabel.text = "님의 집안일"
        choreLabel.textColor = .mcMainGreen
        choreLabel.font = .systemFont(ofSize: 20,
                                      weight: .semibold)
        
        let line = UIView()
        line.backgroundColor = .black
        
        frame.addSubview(nameLabel)
        frame.addSubview(choreLabel)
        frame.addSubview(rightChevronImageView)
        frame.addSubview(line)
        frame.addSubview(todoTableView)
        
        
        
        nameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(32)
            $0.left.equalToSuperview().inset(24)
        }
        
        choreLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.top)
            $0.left.equalTo(nameLabel.snp.right)
        }
        
        rightChevronImageView.snp.makeConstraints {
            $0.centerY.equalTo(nameLabel.snp.centerY)
            $0.right.equalToSuperview().inset(24)
        }
        
        line.snp.makeConstraints {
            $0.top.equalTo(choreLabel.snp.bottom).inset(-10)
            $0.left.equalToSuperview().inset(24)
            $0.width.equalToSuperview().inset(24)
            $0.height.equalTo(1)
        }
        
        todoTableView.snp.makeConstraints {
            $0.top.equalTo(line.snp.bottom).inset(-18)
            $0.left.right.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview()
        }
        
        return frame
    }
    
    //MARK: - groupMemberCircle
    func groupMemberCell(member: Member) -> UIView {
        let circleSize: CGSize = .init(width: 36, height: 36)
        
        let frame = UIView()
        let memberImageView: UIImageView = {
            let image = UIImage(named: "icon_back")
            let result = UIImageView(image: image)
            result.frame = .init(origin: .zero,
                                 size: circleSize)
            return result
        }()
    
        memberImageView.layer.cornerRadius = memberImageView.frame.width / 2
        memberImageView.clipsToBounds = true
        
        
        let memberNameLabel = UILabel()
        memberNameLabel.text = member.name
        memberNameLabel.font = .systemFont(ofSize: 12)
        
        
        frame.addSubview(memberImageView)
        frame.addSubview(memberNameLabel)
        
        
        
        memberImageView.snp.makeConstraints {
            $0.width.height.equalTo(circleSize.width)
            $0.top.equalToSuperview().inset(1)
            $0.left.equalToSuperview()
        }
        
        
        memberNameLabel.snp.makeConstraints {
            $0.top.equalTo(memberImageView.snp.bottom).inset(-4)
            $0.centerX.equalTo(memberImageView)
        }
        
        if member.isSelected {
            let circleFocusView = circleFocusView(size: circleSize)
            
            memberImageView.addSubview(circleFocusView)
            
            circleFocusView.snp.makeConstraints {
                $0.top.left.equalToSuperview()
                $0.size.equalToSuperview()
            }
        }
        
        return frame
    }
    
    func circleFocusView(size: CGSize) -> UIView {
        let circle = UIView()
        
        let circleLayer = CAShapeLayer()
        let circlePath = UIBezierPath(ovalIn: .init(origin: .zero,
                                                    size: size))
        circleLayer.path = circlePath.cgPath
        circleLayer.strokeColor = UIColor.mcMainGreen.cgColor
        circleLayer.lineWidth = 6
        circleLayer.fillColor = UIColor.clear.cgColor
        
        circle.layer.addSublayer(circleLayer)
        
        return circle
    }
    
}

//MARK: - Extension(HomeViewController)
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return members.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TodoTableCell.identifier,
                                                       for: indexPath) as? TodoTableCell
        else { return UITableViewCell() }
        
        cell.setUpAllData(todo: todos[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteButton = UIButton(type: .system)
        deleteButton.setTitle("삭제", for: .normal)
        deleteButton.backgroundColor = .red
        deleteButton.titleLabel?.font = .systemFont(ofSize: 16)
        deleteButton.setTitleColor(.white, for: .normal)
   
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        
        let editButton = UIButton(type: .system)
        editButton.setTitle("수정", for: .normal)
        editButton.backgroundColor = .mcGrey200
        editButton.titleLabel?.font = .systemFont(ofSize: 16)
        editButton.setTitleColor(.mcGrey400, for: .normal)
       
        editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        
        let deleteAction = UIContextualAction(style: .normal, title: "삭제") { [weak self] (action, view, completionHandler) in
            self?.deleteButtonTapped()
            completionHandler(true)
        }
        deleteAction.backgroundColor = .red
        
        let editAction = UIContextualAction(style: .normal, title: "수정") { [weak self] (action, view, completionHandler) in
            self?.editButtonTapped()
            completionHandler(true)
        }
        editAction.backgroundColor = .mcGrey200
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction, editAction])
        configuration.performsFirstActionWithFullSwipe = false
        
        return configuration
    }

    @objc func deleteButtonTapped() {
        // Delete button tapped code
    }

    @objc func editButtonTapped() {
        // Edit button tapped code
        print("edit")
    }
}


class CircularProgressView: UIView {
    private let progressLayer = CAShapeLayer()
    private let progressLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureProgressLayer()
        
        progressLabel.font = .systemFont(ofSize: 22.55,
                                         weight: .semibold)
        addSubview(progressLabel)
        
        progressLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureProgressLayer()
    }
    
    private func configureProgressLayer() {
       
        let radius = 35.0
        let center: CGPoint = .init(x: layer.bounds.midX + radius,
                                    y: layer.bounds.midY + radius)
        
        let startAngle = 0.0
        let endAngle = startAngle + 2 * .pi
        let circularPath = UIBezierPath(arcCenter: center,
                                        radius: radius,
                                        startAngle: startAngle,
                                        endAngle: endAngle,
                                        clockwise: true)
        
        progressLayer.path = circularPath.cgPath
        progressLayer.strokeColor = UIColor.mcMainGreen.cgColor
        progressLayer.lineWidth = 8
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineCap = .round
        
        layoutSubviews()
        layer.addSublayer(progressLayer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        progressLayer.frame = bounds
    }
    
    func setProgress(_ progress: CGFloat) {
        progressLayer.strokeEnd = progress
        
        let flooredProgress = Int(progress * 100)
        progressLabel.text = "\(flooredProgress)%"
    }
    
}
