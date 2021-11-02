//
//  MainTabbar.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/09/22.
//

import UIKit
import SnapKit
import RxViewController

protocol LoginStatue : AnyObject{
    var MoveControllerStatue : UIViewController {get}
}

class MainTabbarController : UITabBarController{
    
    weak var delegateLoginVc : LoginStatue?
    
    private lazy var homeVc = MainViewController()
    let ruleVc = RuleViewController()
    let detailVc = DetailViewController()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        print("\(homeVc)")
        navigationSetting()
        NetworkStatus()
        vcSetting()
        setTabBarBackgroundColor()
    }

    
    //MARK: - Moving ViewController Setting
    private func vcSetting(){
        homeVc.tabBarItem.image = UIImage(named: "BAMBOO_Home")?.withRenderingMode(.alwaysTemplate)
        ruleVc.tabBarItem.image = UIImage(named: "BAMBOO_Rule")?.withRenderingMode(.alwaysTemplate)
        detailVc.tabBarItem.image = UIImage(named: "BAMBOO_Detail")?.withRenderingMode(.alwaysTemplate)
        //MARK: - 무슨 페이지를 보여줄지
        viewControllers = [homeVc,ruleVc,detailVc]
        
    }
    static func instance() -> MainTabbarController {
        return MainTabbarController(nibName: nil, bundle: nil)
    }
    
    //MARK: - Tabbar Setting
    private func setTabBarBackgroundColor() {
        tabBar.layer.applySketchShadow(color: .bamBoo_57CC4D, alpha: 0.25, x: 1, y: 0, blur: 10, spread: 0)
        tabBar.shadowImage = nil
        tabBar.barStyle = .black
        tabBar.tintColor = .bamBoo_57CC4D
        tabBar.unselectedItemTintColor = .lightGray
        tabBar.barTintColor = .white
        tabBar.isTranslucent = false
    }

    //MARK: - Network Connect
    private func NetworkStatus(){
        if NetWorkStatus.shared.isConnect{
            print("wifi connect")
        }else{
            DispatchQueue.main.async { [self] in
                navigationController?.pushViewController(noWifiViewController(), animated: false)
            }
            print("wifi not connect")
        }
    }
    
    //MARK: - Navigation Setting
    private func navigationSetting(){
        navigationController?.navigationCustomBar()
        navigationItem.hidesBackButton = true
        navigationItem.applyImageNavigation()
    }
}

