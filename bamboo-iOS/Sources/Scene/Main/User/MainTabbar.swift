//
//  MainTabbar.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/09/22.
//

//import UIKit
//import SnapKit
//import RxViewController
//
//class MainTabbarController : UITabBarController{
//    //MARK: - Properties
//
//    private let homeVc = MainViewController()
//    private let ruleVc = RuleViewController()
//    private let detailVc = DetailViewController()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .white
//        vcSetting()
//        navigationSetting()
//        NetworkStatus()
//        setTabBarBackgroundColor()
//    }
//
//
//    //MARK: - Moving ViewController Setting
//    private func vcSetting(){
//        homeVc.tabBarItem.image = UIImage(named: "BAMBOO_Home")?.withRenderingMode(.alwaysTemplate)
//        ruleVc.tabBarItem.image = UIImage(named: "BAMBOO_Rule")?.withRenderingMode(.alwaysTemplate)
//        detailVc.tabBarItem.image = UIImage(named: "BAMBOO_Detail")?.withRenderingMode(.alwaysTemplate)
//        //MARK: - 무슨 페이지를 보여줄지
//        viewControllers = [homeVc,ruleVc,detailVc]
//    }
//
//    //MARK: - Tabbar Setting
//    private func setTabBarBackgroundColor() {
//        tabBar.layer.applySketchShadow(color: .bamBoo_57CC4D, alpha: 0.25, x: 1, y: 0, blur: 10, spread: 0)
//        tabBar.shadowImage = nil
//        tabBar.barStyle = .black
//        tabBar.tintColor = .bamBoo_57CC4D
//        tabBar.unselectedItemTintColor = .lightGray
//        tabBar.barTintColor = .white
//        tabBar.isTranslucent = false
//    }
//
//    //MARK: - Network Connect
//    private func NetworkStatus(){
//        if NetWorkStatus.shared.isConnect{
//            print("wifi connect")
//        }else{
//            DispatchQueue.main.async { [self] in
//                navigationController?.pushViewController(noWifiViewController(), animated: false)
//            }
//            print("wifi not connect")
//        }
//    }
//
//    //MARK: - Navigation Setting
//    private func navigationSetting(){
//        navigationController?.navigationCustomBar()
//        navigationItem.hidesBackButton = true
//        navigationItem.applyImageNavigation()
//    }
//}
