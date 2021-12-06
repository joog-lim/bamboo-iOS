//
//  ManagerMainFlow.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/12/06.
//

import UIKit

import RxSwift
import RxFlow

final class ManagerMainFlow : Flow{
    enum TabIndex : Int{
        case accept = 0
        case standBy = 1
        case Refusal = 2
        case Delete = 3
    }
    var root: Presentable{
        return self.rootViewController
    }
    let rootViewController: UITabBarController = .init()
    private let homeFlow : AcceptFlow
    private let ruleFlow : RuleFlow
    private let detailFlow : DetailFlow
    
    init(){
        self.homeFlow = .init(stepper: .init())
        self.ruleFlow = .init(stepper: .init())
        self.detailFlow = .init(stepper: .init())
    }
    deinit{
        print("\(type(of: self)): \(#function)")
    }
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step.asBambooStep else {return .none}
        switch step{
        case .LoginIsRequired:
            return .end(forwardToParentFlowWithStep: BambooStep.LoginIsRequired)
        case .userMainTabBarIsRequired:
            return coordinateToMainTabBar()
        default:
            return .none
        }
    }
    private func coordinateToMainTabBar() -> FlowContributors{
        Flows.use(
            homeFlow,ruleFlow,detailFlow,
            when: .created)
        { [unowned self] (root1 : UINavigationController,
                                                                                  root2 : UINavigationController,
                                                                                  root3 : UINavigationController)  in
            let homeImage : UIImage? = UIImage(named: "BAMBOO_Home")
            let ruleImage : UIImage? = UIImage(named: "BAMBOO_Rule")
            let detailImage : UIImage? = UIImage(named: "BAMBOO_Detail")
            
            let homeItem : UITabBarItem = .init(title: "홈", image: homeImage, selectedImage: nil)
            let ruleItem : UITabBarItem = .init(title: "규칙", image: ruleImage, selectedImage: nil)
            let detailItem : UITabBarItem = .init(title: "더보기", image: detailImage, selectedImage: nil)
            
            root1.tabBarItem = homeItem
            root2.tabBarItem = ruleItem
            root3.tabBarItem = detailItem
            
            self.rootViewController.setViewControllers([root1,root2,root3], animated: true)
        }
        return .multiple(flowContributors: [
            .contribute(withNextPresentable: homeFlow,withNextStepper: homeFlow.stepper),
            .contribute(withNextPresentable: ruleFlow,withNextStepper: ruleFlow.stepper),
            .contribute(withNextPresentable: detailFlow,withNextStepper: detailFlow.stepper)
        ])
    }
    
}

