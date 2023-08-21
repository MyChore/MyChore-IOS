//
//  RepeatSelectViewController.swift
//  MyChore
//
//  Created by 경유진 on 2023/07/31.
//

import UIKit

import Pageboy
import SnapKit
import Tabman

class RepeatSelectViewController: UIViewController {
    
    var completionHandler: ((String) -> (String))?
    
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
        titleLabel.text = "반복"
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
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    lazy var containerView: UIView = {
        let containerView = UIView()
        return containerView
    }()
    
    let tabViewController = TabViewController()
    
    func setUpView() {
        view.addSubview(containerView)
        addChild(tabViewController)
        containerView.addSubview(tabViewController.view)
        tabViewController.view.frame = containerView.bounds
    }
    
    func setConstraints() {
        containerView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(20)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
}

class TabViewController: TabmanViewController {
    
    private var viewControllers: [UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTab()
    }
    
    func setUpTab() {
        let firstVC = RepeatPeriodViewController()
        let secondVC = RepeatEndViewController()
        
        
        viewControllers.append(firstVC)
        viewControllers.append(secondVC)
        
        self.dataSource = self
        //self.isScrollEnabled = false
        
        let bar = TMBar.ButtonBar()
        bar.layout.contentInset = UIEdgeInsets(top: 0.0, left: 24.0, bottom: 0.0, right: 24.0)
        bar.layout.transitionStyle = .snap
        //bar.layout.alignment = .centerDistributed
        //bar.layout.contentMode = .intrinsic
        bar.backgroundView.style = .blur(style: .light)
        bar.layout.contentMode = .fit
        
        bar.buttons.customize { (button) in
            button.tintColor = UIColor.mcGrey800 // 선택 안되어 있을 때
            //button.backgroundColor = UIColor.mcGrey200
            button.selectedTintColor = UIColor.mcMainGreen // 선택 되어 있을 때
            
        }
        
        bar.indicator.tintColor = .clear
        addBar(bar, dataSource: self, at: .top)
    }
        
}


extension TabViewController: PageboyViewControllerDataSource, TMBarDataSource {

    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewControllers.count
    }

    func viewController(for pageboyViewController: PageboyViewController,
                        at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }

    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }

    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        switch index {
        case 0:
            return TMBarItem(title: "반복 주기")
        case 1:
            return TMBarItem(title: "반복 종료")
        default:
            let title = "Page: \(index)"
            return TMBarItem(title: title)
        }
    }
}
