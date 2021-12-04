//
//  MannagerTabbar.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/12/01.
//

import UIKit
import SnapKit
import RxViewController

class MannagerTabbar : UITabBarController{
    //MARK: - Properties
    
    private let access = AcceptViewController()
    private let standBy = StandByViewController()
    private let refusal = RefusalViewController()
    private let delete = DeleteViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        vcSetting()
        navigationSetting()
        NetworkStatus()
        setTabBarBackgroundColor()
    }
    
    //MARK: - Selector
    @objc private func navigationbarItemAction(){
        navigationController?.pushViewController(RuleViewController(), animated: true)
    }
    @objc private func MainViewControllerNavigationAction(){
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Moving ViewController Setting
    private func vcSetting(){
        access.tabBarItem.image = UIImage(systemName: "circle")?.withRenderingMode(.alwaysTemplate)
        standBy.tabBarItem.image = UIImage(systemName: "stop")?.withRenderingMode(.alwaysTemplate)
        refusal.tabBarItem.image = UIImage(systemName: "exclamationmark.triangle")?.withRenderingMode(.alwaysTemplate)
        delete.tabBarItem.image = UIImage(systemName: "minus.circle")?.withRenderingMode(.alwaysTemplate)

        //MARK: - 무슨 페이지를 보여줄지
        viewControllers = [access,standBy,refusal,delete]
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
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(MainViewControllerNavigationAction))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "square.stack.3d.forward.dottedline.fill"), style: .plain, target: self, action: #selector(navigationbarItemAction))
        navigationItem.leftBarButtonItem?.tintColor = .bamBoo_57CC4D
        navigationItem.rightBarButtonItem?.tintColor = .rgb(red: 118, green: 177, blue: 87)
        navigationItem.applyImageNavigation()
    }
}
