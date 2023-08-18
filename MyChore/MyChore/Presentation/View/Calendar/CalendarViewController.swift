//
//  Calendar.swift
//  MyChore
//
//  Created by sole on 2023/07/29.
//

import UIKit
import SnapKit

struct Todo {
    let todo: String
    let furnitureName: String
    let spaceName: String?
    var isComplete: Bool
    
    init(todo: String,
         furnitureName: String,
         spaceName: String?,
         isComplete: Bool = false) {
        self.todo = todo
        self.furnitureName = furnitureName
        self.spaceName = spaceName
        self.isComplete = isComplete
    }
}

var todos = [Todo(todo: "침구 정리",
                  furnitureName: "침대",
                  spaceName: "침실"),
             Todo(todo: "의자 정리",
                               furnitureName: "의자 정리",
                               spaceName: "침실"),
             Todo(todo: "빨래 정리",
                               furnitureName: "바닥",
                  spaceName: "침실"),
             Todo(todo: "옷장 정리",
                               furnitureName: "옷장",
                               spaceName: "안방"),
             Todo(todo: "베란다 청소",
                               furnitureName: "바닥",
                               spaceName: nil),
             Todo(todo: "침구 정리",
                               furnitureName: "침대",
                               spaceName: "침실"),
                          Todo(todo: "의자 정리",
                                            furnitureName: "의자 정리",
                                            spaceName: "침실"),
                          Todo(todo: "빨래 정리",
                                            furnitureName: "바닥",
                               spaceName: "침실"),
                          Todo(todo: "옷장 정리",
                                            furnitureName: "옷장",
                                            spaceName: "안방"),
                          Todo(todo: "베란다 청소",
                                            furnitureName: "바닥",
                                            spaceName: nil)]


class CalendarViewController: ViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 내비게이션 바 숨김
        navigationController?.navigationBar.isHidden = true
        
        view.backgroundColor = .white
        
        let dailyAchievementsSection = dailyAchievementsSection(archivementRate: 40,
                                    nickName: "삼공")
        
        let todoRow = todoRow(todo: "침구 닦기",
                              furnitureName: "침대",
                              spaceName: "침실")

        let todoScrollView = todoScrollView(todos: todos)
        
        view.addSubview(titleBar)
        view.addSubview(filterBar)
        view.addSubview(dailyAchievementsSection)
        view.addSubview(todoScrollView)
        
        
        
        titleBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.width.equalToSuperview()
            $0.height.equalTo(52)
        }
        
        dailyAchievementsSection.snp.makeConstraints {
            $0.top.equalTo(titleBar.snp.bottom).inset(-20)
            $0.left.right.equalToSuperview().inset(24)
        }

        filterBar.snp.makeConstraints {
            $0.top.equalTo(dailyAchievementsSection.snp.bottom).inset(-38)
            $0.width.equalToSuperview()
            $0.height.equalTo(52)
            
        }
  

        todoScrollView.snp.makeConstraints {
            $0.top.equalTo(filterBar.snp.bottom).inset(-24)
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.greaterThanOrEqualTo(400)
        }
        
        
    }
    
    /// 최상단의 타이틀 바 섹션입니다.
    //MARK: - titleBar
    let titleBar: UIView = {
        let titleFrame = UIView()
        let titleLabel = UILabel()
        titleLabel.text = "기록"
        titleLabel.font = UIFont.systemFont(ofSize: 20,
                                            weight: .semibold)
        
        titleFrame.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        return titleFrame
    }()
    
    /// 필터링 버튼이 있는 바 섹션입니다.
    //MARK: - filterBar
    let filterBar: UIView = {
        let filterFrame = UIView()
        filterFrame.backgroundColor = .mcGrey100
        
        let peopleFilterButton = UIButton()
        peopleFilterButton.backgroundColor = .white
        peopleFilterButton.layer.cornerRadius = 4
        peopleFilterButton.layer.borderWidth = 1
        peopleFilterButton.layer.borderColor = UIColor.mcMainGreen.cgColor
        
        

        //FIXME: 임시 아이콘
        let peopleImageView: UIImageView = {
            let peopleImage = UIImage(systemName: "person.2")
            let resizedImage = peopleImage?.setSizeAndColor(width: 10,
                                         height: 10,
                                         color: .mcMainGreen)
            return UIImageView(image: resizedImage)
        }()
        
        //FIXME: 임시 아이콘
        let downChevronImageView: UIImageView = {
            let downChevronImage = UIImage(systemName: "chevron.down")
            let resizedImage = downChevronImage?.setSizeAndColor(width: 10,
                                         height: 10,
                                         color: .mcMainGreen)
            return UIImageView(image: resizedImage)
        }()
        
        let filterTextLabel = UILabel()
        filterTextLabel.text = "정렬"
        filterTextLabel.font = UIFont.systemFont(ofSize: 16,
                                             weight: .medium)
        
        let upDownArrowImageView : UIImageView = {
            let upDownArrowImage = UIImage(systemName: "arrow.up.arrow.down")
            let result = UIImageView(image: upDownArrowImage)
            result.tintColor = .black
            return result
        }()
        
        
        filterFrame.addSubview(peopleFilterButton)
        
        peopleFilterButton.addSubview(peopleImageView)
        peopleFilterButton.addSubview(downChevronImageView)
        
        filterFrame.addSubview(filterTextLabel)
        filterFrame.addSubview(upDownArrowImageView)
        
        peopleFilterButton.snp.makeConstraints {
            $0.left.equalToSuperview().inset(24)
            $0.centerY.equalToSuperview()
        }
        
        peopleImageView.snp.makeConstraints {
            $0.width.height.equalTo(28)
            $0.left.equalToSuperview().inset(8)
            $0.top.equalToSuperview().inset(5)
            $0.bottom.equalToSuperview().inset(3)
        }
        
        downChevronImageView.snp.makeConstraints {
            $0.width.height.equalTo(22)
            $0.left.equalTo(peopleImageView.snp.right).inset(5)
            $0.right.equalToSuperview().inset(4)
            $0.top.equalToSuperview().inset(8)
            $0.bottom.equalToSuperview().inset(6)
        }
        
        filterTextLabel.snp.makeConstraints {
            $0.right.equalToSuperview().inset(24)
            $0.centerY.equalToSuperview()
        }
        
        upDownArrowImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(32)
            $0.right.equalTo(filterTextLabel.snp.left).inset(-5)
        }
        
        
        return filterFrame
    }()
    
    // FIXME: label 임시값 실제값으로 변경
    /// 날짜별 집안일 달성율을 보여주는 섹션입니다.
    //MARK: - dailyAchievementsSection
    func dailyAchievementsSection(date: Date = .init(),
                                  archivementRate: Int,
                                  nickName: String) -> UIView {

        let frame = UIView()
        
        let dateLabel = UILabel()
        dateLabel.text = "2023년 7월 2주차"
        dateLabel.font = UIFont.systemFont(ofSize: 16,
                                           weight: .medium)
        
        let leftChevronImageView: UIImageView = {
            let leftChevronImage = UIImage(systemName: "chevron.backward")
            let result = UIImageView(image: leftChevronImage)
            result.tintColor = .black
            return result
        }()
        
        let rightChevronImageView: UIImageView = {
            let rightChevronImage = UIImage(systemName: "chevron.right")
            let result = UIImageView(image: rightChevronImage)
            result.tintColor = .black
            return result
        }()
        
        let nameLabel = UILabel()
        nameLabel.text = "\(nickName)님"
        nameLabel.textColor = .mcMainGreen
        nameLabel.font = UIFont.systemFont(ofSize: 26,
                                           weight: .semibold)
        
        let statusTextLabel = UILabel()
        statusTextLabel.text = "조금 더\n노력해야겠어요"
        statusTextLabel.numberOfLines = 2
        statusTextLabel.font = UIFont.systemFont(ofSize: 26,
                                           weight: .semibold)
        
        let rateText = UILabel()
        rateText.text = "\(archivementRate)%"
        rateText.font = UIFont.systemFont(ofSize: 20,
                                          weight: .semibold)
        
        let progressView = UIProgressView()
        progressView.tintColor = .mcMainGreen
        progressView.progress = Float(Double(archivementRate) / 100.0)
        
        let illustrationImageView: UIImageView = {
            let image = UIImage(systemName: "paperclip.circle.fill")
            let result = UIImageView(image: image)
            result.tintColor = .mcMainGreen
            return result
        }()
        
        frame.addSubview(dateLabel)
        frame.addSubview(leftChevronImageView)
        frame.addSubview(rightChevronImageView)
        frame.addSubview(nameLabel)
        frame.addSubview(statusTextLabel)
        frame.addSubview(rateText)
        frame.addSubview(progressView)
        frame.addSubview(illustrationImageView)
       
        frame.snp.makeConstraints {
            $0.height.greaterThanOrEqualTo(216)
        }
        
        dateLabel.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
        }
        
        leftChevronImageView.snp.makeConstraints {
            $0.width.height.lessThanOrEqualTo(32)
            $0.centerY.equalTo(dateLabel)
            $0.right.equalTo(rightChevronImageView.snp.left).inset(-5)
        }
        
        rightChevronImageView.snp.makeConstraints {
            $0.width.height.lessThanOrEqualTo(32)
            $0.centerY.equalTo(dateLabel)
            $0.right.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).inset(-34)
            $0.left.equalToSuperview()
        }

        statusTextLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).inset(-5)
            $0.left.equalToSuperview()
        }
        
        rateText.snp.makeConstraints {
            $0.top.equalTo(statusTextLabel.snp.bottom).inset(-53)
            $0.left.equalToSuperview()
        }
        
        progressView.snp.makeConstraints {
            $0.top.equalTo(rateText.snp.bottom).inset(-6)
            $0.left.equalToSuperview()
            $0.width.lessThanOrEqualTo(174)
            $0.height.equalTo(5)
            $0.bottom.lessThanOrEqualToSuperview()
        }
        
        illustrationImageView.snp.makeConstraints {
            $0.width.height.lessThanOrEqualTo(150)
            $0.right.equalToSuperview()
            $0.bottom.equalTo(progressView.snp.bottom)
        }
        
        return frame
    }
    
    
    //MARK: - spaceTag
    /// 장소 태그를 생성하는 메서드입니다.
    func spaceTag(spaceName: String?) -> UIView {
        guard let spaceName else { return UIView() }
        let ellipse = UIView()
        ellipse.layer.cornerRadius = 12
        ellipse.backgroundColor = .mcMainGreen
        
        let spaceLabel = UILabel()
        spaceLabel.text = spaceName
        spaceLabel.textColor = .white
        spaceLabel.font = UIFont.systemFont(ofSize: 15,
                                            weight: .medium)
        
        ellipse.addSubview(spaceLabel)
        
        ellipse.snp.makeConstraints {
            $0.width.lessThanOrEqualTo(50)
            $0.height.lessThanOrEqualTo(28)
        }
        
        spaceLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        return ellipse
    }
    
    
    //MARK: - todoElement
    /// 할 일 section입니다.
    func todoElement(todo: String,
                     furnitureName: String) -> UIView {
        let frame = UIView()
        
        
        let todoLabel = UILabel()
        todoLabel.text = todo
        todoLabel.font = UIFont.systemFont(ofSize: 16,
                                           weight: .regular)
        
        let furnitureAndTimeLabel = UILabel()
        furnitureAndTimeLabel.text = "\(furnitureName) - 매일 - 3:00PM"
        furnitureAndTimeLabel.textColor = .mcGrey600
        furnitureAndTimeLabel.font = UIFont.systemFont(ofSize: 12,
                                                       weight: .regular)
        
        
        let checkBox = CheckBoxButton()
        
        let divider = UIView()
        divider.backgroundColor = .mcGrey300
        
        frame.addSubview(todoLabel)
        frame.addSubview(furnitureAndTimeLabel)
        frame.addSubview(checkBox)
        frame.addSubview(divider)
        
        
        
        frame.snp.makeConstraints {
            $0.height.greaterThanOrEqualTo(56)
        }
        
        
        todoLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(4)
            $0.left.equalToSuperview().inset(4)
        }
        
        furnitureAndTimeLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(28)
            $0.left.equalToSuperview().inset(6)
        }
        
        checkBox.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(20)
            $0.right.equalToSuperview().inset(8)
        }
        
        divider.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.width.equalToSuperview()
            $0.top.equalTo(furnitureAndTimeLabel.snp.bottom).inset(-4)
            $0.bottom.equalToSuperview().inset(4)
            $0.left.equalToSuperview()
        }
       
        return frame
    }
    
    //MARK: - todoRow
    /// scrollView에 들어가는 todoRow 입니다.
    ///
    func todoRow(todo: String,
                 furnitureName: String,
                 spaceName: String?) -> UIView {
        let frame = UIView()
        let spaceTag = spaceTag(spaceName: spaceName)
        let todoElement = todoElement(todo: todo,
                                      furnitureName: furnitureName)
        
        frame.addSubview(spaceTag)
        frame.addSubview(todoElement)
        
        spaceTag.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.top.equalToSuperview()
        }
        
        todoElement.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.right.equalToSuperview()
            $0.left.equalToSuperview().inset(66)
        }
        
        return frame
    }
    
    
    /// todoScrollView의 전체 UI입니다.
    //MARK: - todoScrollView
    func todoScrollView(todos: [Todo]) -> UIView {
        let scrollFrame = UIScrollView()
        
        let content = UIStackView()
        content.axis = .vertical
        
        
        scrollFrame.addSubview(content)
        scrollFrame.contentSize = CGSize(width: scrollFrame.frame.width,
                                         height: content.frame.height)
        
        
        todos.map { todo in
            return todoRow(todo: todo.todo,
                           furnitureName: todo.furnitureName,
                           spaceName: todo.spaceName)
        }.forEach { todoRow in
            content.addArrangedSubview(todoRow)
            todoRow.snp.makeConstraints {
                $0.height.greaterThanOrEqualTo(56)
            }
        }
        
        content.snp.makeConstraints {
            $0.top.equalTo(scrollFrame.contentLayoutGuide.snp.top)
            $0.bottom.equalTo(scrollFrame.contentLayoutGuide.snp.bottom)
            $0.left.equalTo(scrollFrame.contentLayoutGuide.snp.left).inset(24)
            $0.right.equalTo(scrollFrame.contentLayoutGuide.snp.right).inset(24)
            $0.width.equalToSuperview().inset(24)
        }
        
        return scrollFrame
    }
    
}






