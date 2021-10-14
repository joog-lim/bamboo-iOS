//
//  MainTabbar.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/09/22.
//

import UIKit

import RxViewController
//protocol ChoosingViewControllerDelegate: class{
//    var vc : UIViewController {get}
//}
//class MainTabbar : BaseViewController{
//    //MARK: - Properties
//
//    weak var delegate : ChoosingViewControllerDelegate?
//
//    private let mainTabBarView = CustomTabbar()
//    private lazy var mainViewController = MainViewController()
//    private let ruleViewController = RuleViewController()
//    private let detailViewController = DetailViewController()
//    private let viewControllerBoxView = UIView()
//
//    //MARK: - Selectors
//
//    @objc func home(sender:UIButton){
//        self.addChild(mainViewController)
//        mainViewController.view.frame = viewControllerBoxView.frame
//        viewControllerBoxView.addSubview(mainViewController.view)
//        removeRule()
//        removeDetail()
//        mainTabBarView.homeBtn.tintColor = .bamBoo_57CC4D
//    }
//    @objc func rule(sender:UIButton){
//        self.addChild(ruleViewController)
//        ruleViewController.view.frame = viewControllerBoxView.frame
//        viewControllerBoxView.addSubview(ruleViewController.view)
//        removeMain()
//        removeDetail()
//        mainTabBarView.ruleBtn.tintColor = .bamBoo_57CC4D
//    }
//    @objc func detail(sender:UIButton){
//        self.addChild(detailViewController)
//        detailViewController.view.frame = viewControllerBoxView.frame
//        viewControllerBoxView.addSubview(detailViewController.view)
//        removeMain()
//        removeRule()
//        mainTabBarView.detailsBtn.tintColor = .bamBoo_57CC4D
//    }
//
//    //MARK: - Remove Page
//    private func removeMain(){
//        mainViewController.removeFromParent()
//        mainViewController.view.removeFromSuperview()
//        mainTabBarView.homeBtn.tintColor = .lightGray
//    }
//    private func removeRule(){
//        ruleViewController.removeFromParent()
//        ruleViewController.view.removeFromSuperview()
//        mainTabBarView.ruleBtn.tintColor = .lightGray
//    }
//    private func removeDetail(){
//        mainTabBarView.detailsBtn.tintColor = .lightGray
//        detailViewController.removeFromParent()
//        detailViewController.view.removeFromSuperview()
//    }
//
//    //MARK: - Helper
//    override func configure() {
//        super.configure()
//        navigationSetting()
//        NetworkStatus()
//        tabbarInitalizer()
//    }
//    override func configureAppear() {
//        super.configureAppear()
//        addView()
//        buttonTargetting()
//        location()
//    }
//
//    //MARK: - AddView
//    private  func addView(){
//        self.view.addSubview(mainTabBarView)
//        self.view.addSubview(viewControllerBoxView)
//    }
//    //MARK: - tabbar Initalizer
//    private func tabbarInitalizer(){
//        self.addChild(mainViewController)
//        mainViewController.view.frame = viewControllerBoxView.frame
//        viewControllerBoxView.addSubview(mainViewController.view)
//    }
//    //MARK: - Location
//    private func location(){
//        viewControllerBoxView.snp.makeConstraints { (make) in
//            make.top.left.right.equalToSuperview()
//            make.bottom.equalTo(mainTabBarView.snp.top)
//        }
//        mainTabBarView.snp.makeConstraints {
//            $0.height.equalTo(view.frame.height/9.9024)
//            $0.left.right.bottom.equalToSuperview()
//        }
//    }
//    //MARK: - button Targetting
//    private func buttonTargetting(){
//        mainTabBarView.homeBtn.addTarget(self, action: #selector(home(sender:)), for: .touchUpInside)
//        mainTabBarView.ruleBtn.addTarget(self, action: #selector(rule(sender:)), for: .touchUpInside)
//        mainTabBarView.detailsBtn.addTarget(self, action: #selector(detail(sender:)), for: .touchUpInside)
//    }
//
//    //MARK: - Navigation Setting
//    private func navigationSetting(){
//        navigationController?.navigationCustomBar()
//        navigationItem.hidesBackButton = true
//        navigationItem.applyImageNavigation()
//    }
//    //MARK: - Network Connect
//    private func NetworkStatus(){
//        if NetWorkStatus.shared.isConnect{
//            print("wifi connect")
//        }else{
//            DispatchQueue.main.async {
//                self.navigationController?.pushViewController(noWifiViewController(), animated: false)
//            }
//            print("wifi not connect")
//        }
//    }
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//    }
//}
class MainTabbarController : UITabBarController{
    
    let homeVc = MainViewController()
    
    let ruleVc = RuleViewController()
    
    let detailVc = DetailViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationSetting()
        NetworkStatus()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        vcSetting()
        setTabBarBackgroundColor()
    }
    
    //MARK: - Moving ViewController Setting
    private func vcSetting(){
        homeVc.tabBarItem.image = UIImage(named: "BAMBOO_Home")?.withRenderingMode(.alwaysTemplate)
        ruleVc.tabBarItem.image = UIImage(named: "BAMBOO_Rule")?.withRenderingMode(.alwaysTemplate)
        detailVc.tabBarItem.image = UIImage(named: "BAMBOO_Detail")?.withRenderingMode(.alwaysTemplate)
        
        //MARK: - Tabbar 색상 조정
        tabBar.tintColor = .bamBoo_57CC4D
        tabBar.unselectedItemTintColor = .lightGray
        //MARK: - 무슨 페이지를 보여줄지
        viewControllers = [homeVc,ruleVc,detailVc]
        tabBar.barTintColor = .white
    }
    func setTabBarBackgroundColor() {
        tabBar.layer.applySketchShadow(color: .bamBoo_57CC4D, alpha: 0.25, x: 1, y: 0, blur: 10, spread: 0)
        tabBar.shadowImage = nil
        tabBar.barStyle = .black
        tabBar.barTintColor = .white
         tabBar.isTranslucent = false
    }
    //MARK: - Network Connect
    private func NetworkStatus(){
        if NetWorkStatus.shared.isConnect{
            print("wifi connect")
        }else{
            DispatchQueue.main.async {
                self.navigationController?.pushViewController(noWifiViewController(), animated: false)
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
