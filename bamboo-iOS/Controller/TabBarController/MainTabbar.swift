//
//  MainTabbar.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/09/22.
//

import UIKit

class MainTabbar : UIViewController{
    //MARK: - Properties

    lazy var mainTabBarView = CustomTabbar()
    
    let mainViewController = MainViewController()
    let ruleViewController = RuleViewController()
    let detailViewController = DetailViewController()
    
    let viewControllerBoxView = UIView()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        navigationSetting()
        view.backgroundColor = .white
        
    }
    //MARK: - Selectors
   
    
    @objc func home(sender:UIButton){
        self.addChild(mainViewController)
        mainViewController.view.frame = viewControllerBoxView.frame
        viewControllerBoxView.addSubview(mainViewController.view)
        removeRule()
        removeDetail()
        mainTabBarView.homeBtn.tintColor = .bamBoo_57CC4D
        mainTabBarView.ruleBtn.tintColor = .lightGray
        mainTabBarView.detailsBtn.tintColor = .lightGray
    }
    @objc func rule(sender:UIButton){
        self.addChild(ruleViewController)
        ruleViewController.view.frame = viewControllerBoxView.frame
        viewControllerBoxView.addSubview(ruleViewController.view)
        removeMain()
        removeDetail()
        mainTabBarView.ruleBtn.tintColor = .bamBoo_57CC4D
        mainTabBarView.homeBtn.tintColor = .lightGray
        mainTabBarView.detailsBtn.tintColor = .lightGray
    }
    @objc func detail(sender:UIButton){
        self.addChild(detailViewController)
        detailViewController.view.frame = viewControllerBoxView.frame
        viewControllerBoxView.addSubview(detailViewController.view)
        removeMain()
        removeRule()
        mainTabBarView.detailsBtn.tintColor = .bamBoo_57CC4D
        mainTabBarView.homeBtn.tintColor = .lightGray
        mainTabBarView.ruleBtn.tintColor = .lightGray
    }
    //MARK: - Remove Page
    func removeMain(){
        mainViewController.removeFromParent()
        mainViewController.view.removeFromSuperview()
    }
    func removeRule(){
        ruleViewController.removeFromParent()
        ruleViewController.view.removeFromSuperview()
    }
    func removeDetail(){
        detailViewController.removeFromParent()
        detailViewController.view.removeFromSuperview()
    }
    
    //MARK: - Helper
    func configureUI(){
        self.view.addSubview(mainTabBarView)
        self.view.addSubview(viewControllerBoxView)
        mainTabBarView.homeBtn.addTarget(self, action: #selector(home(sender:)), for: .touchUpInside)
        mainTabBarView.ruleBtn.addTarget(self, action: #selector(rule(sender:)), for: .touchUpInside)
        mainTabBarView.detailsBtn.addTarget(self, action: #selector(detail(sender:)), for: .touchUpInside)
        viewControllerBoxView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(mainTabBarView.snp.top)
        }
        mainTabBarView.snp.makeConstraints {
            $0.height.equalTo(view.frame.height/9.9024)
            $0.left.right.bottom.equalToSuperview()
        }
        self.addChild(mainViewController)
        mainViewController.view.frame = viewControllerBoxView.frame
        viewControllerBoxView.addSubview(mainViewController.view)
    }
    //MARK: - Navigation Setting
    func navigationSetting(){
        navigationController?.navigationCustomBar()
        navigationItem.hidesBackButton = true
        navigationItem.applyImageNavigation()
    }
}
