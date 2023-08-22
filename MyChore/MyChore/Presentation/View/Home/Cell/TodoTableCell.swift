//
//  TodoTableCell.swift
//  MyChore
//
//  Created by sole on 2023/08/19.
//

import UIKit

class TodoTableCell: UITableViewCell {
    
    static let identifier = "TodoTableCell"
    
    let spaceTagLabel = UILabel()
    let todoLabel = UILabel()
    let furnitureAndTimeLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle,
                  reuseIdentifier: String?) {
        super.init(style: style,
                   reuseIdentifier: reuseIdentifier)
        
        let todoRow = todoRow()
        
        contentView.addSubview(todoRow)
        
        todoRow.snp.makeConstraints {
            $0.edges.equalTo(contentView.snp.edges)
        }
    }
    
    
    func setUpAllData(todo: Todo) {
        setUpTodoData(todo: todo)
    }
    
    func setUpTodoData(todo: Todo) {
        todoLabel.text = todo.todo
        furnitureAndTimeLabel.text = todo.furnitureName
        spaceTagLabel.text = todo.spaceName
    }
    
    
    func todoElement() -> UIView {
        let frame = UIView()
        
        todoLabel.font = UIFont.systemFont(ofSize: 16,
                                           weight: .regular)
        
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
            $0.height.greaterThanOrEqualTo(60)
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
    func todoRow() -> UIView {
        let frame = UIView()
        if spaceTagLabel.text != nil {
            let spaceTag = makeTag()
            frame.addSubview(spaceTag)
            spaceTag.snp.makeConstraints {
                $0.left.equalToSuperview()
                $0.top.equalToSuperview()
            }
        }
        
        
        let todoElement = todoElement()
        
        frame.addSubview(todoElement)
        
        
        todoElement.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.right.equalToSuperview()
            $0.left.equalToSuperview().inset(66)
        }
        
        return frame
    }
    
    //MARK: - makeTag
    /// 태그를 생성하는 메서드입니다.
    func makeTag() -> UIView {
        let ellipse = UIView()
        ellipse.layer.cornerRadius = 12
        ellipse.backgroundColor = .mcMainGreen
     
        spaceTagLabel.textColor = .white
        spaceTagLabel.font = UIFont.systemFont(ofSize: 15,
                                            weight: .medium)
        
        ellipse.addSubview(spaceTagLabel)
        
        ellipse.snp.makeConstraints {
            $0.width.equalTo(50)
            $0.height.equalTo(28)
        }
        
        spaceTagLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        return ellipse
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

