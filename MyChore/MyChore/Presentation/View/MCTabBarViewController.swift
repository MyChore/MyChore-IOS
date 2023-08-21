//
//  MCTabBarViewController.swift
//  MyChore
//
//  Created by sole on 2023/08/21.
//

import UIKit

class MCTabBarViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let tabBar = UITabBarController()
        tabBar.tabBar.tintColor = .mcMainGreen
        
        let home = UINavigationController(rootViewController: HomeViewController())
        home.tabBarItem = UITabBarItem(title: "홈", image: UIImage(named: "home"),
                                       selectedImage: UIImage(named: "home"))
        
        let calendar = UINavigationController(rootViewController: CalendarViewController())
        calendar.tabBarItem = UITabBarItem(title: "캘린더",
                                           image: UIImage(named: "calendar"),
                                           selectedImage: UIImage(named: "calendar"))
        
        let addFloorPlan = UINavigationController(rootViewController: ChoreAddMainViewController())
        addFloorPlan.tabBarItem = UITabBarItem(title: "추가", image: UIImage(named: "add"),
                                       selectedImage: UIImage(named: "add"))
        let manage = UINavigationController(rootViewController: manage())
        manage.tabBarItem = UITabBarItem(title: "관리", image: UIImage(named: "manage"),
                                       selectedImage: UIImage(named: "manage"))
        
        let profile = UINavigationController(rootViewController: MypageMainViewController())
        profile.tabBarItem = UITabBarItem(title: "내 정보", image: UIImage(named: "profile"),
                                       selectedImage: UIImage(named: "profile"))
        
        tabBar.setViewControllers([home, calendar, addFloorPlan, manage, profile],
                                  animated: animated)
        tabBar.tabBar.backgroundColor = .white
        
        
        tabBar.modalPresentationStyle = .fullScreen
        self.present(tabBar, animated: false, completion: nil)
        
        
    }
    
}



class addFloorPlan: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .mcMainGreen
        title = "추가"
    }
}

class manage: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .mcMainGreen
        title = "관리"
    }
}
