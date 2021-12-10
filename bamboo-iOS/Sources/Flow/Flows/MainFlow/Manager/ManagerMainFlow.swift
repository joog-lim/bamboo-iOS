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
        case refusal = 2
        case delete = 3
    }
    var root: Presentable{
        return self.rootViewController
    }
    let rootViewController: UITabBarController = .init()
    private let acceptFlow : AcceptFlow
    private let standByFlow : StandByFlow
    private let refusalFlow : RefusalFlow
    private let deleteFlow : DeleteFlow
    
    init(){
        self.acceptFlow = .init(stepper: .init())
        self.standByFlow = .init(stepper: .init())
        self.refusalFlow = .init(stepper: .init())
        self.deleteFlow = .init(stepper: .init())
    }
    deinit{
        print("\(type(of: self)): \(#function)")
    }
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step.asBambooStep else {return .none}
        switch step{
        case .LoginIsRequired:
            return .end(forwardToParentFlowWithStep: BambooStep.LoginIsRequired)
        case .managerMainTabBarIsRequired:
            return coordinateToMainTabBar()
        default:
            return .none
        }
    }
    private func coordinateToMainTabBar() -> FlowContributors{
        Flows.use(
            acceptFlow,standByFlow,refusalFlow,deleteFlow,
            when: .created)
        { [unowned self] (root1 : UINavigationController,
                          root2 : UINavigationController,
                          root3 : UINavigationController,
                          root4 : UINavigationController)  in
            
            let acceptImage : UIImage? = UIImage(named: "BAMBOO_Home")?.withRenderingMode(.alwaysTemplate)
            let standByImage : UIImage? = UIImage(named: "BAMBOO_Rule")?.withRenderingMode(.alwaysTemplate)
            let refusalImage : UIImage? = UIImage(named: "BAMBOO_Detail")?.withRenderingMode(.alwaysTemplate)
            let deleteImage : UIImage? = UIImage(named: "BAMBOO_Detail")?.withRenderingMode(.alwaysTemplate)

            
            let acceptItem : UITabBarItem = .init(title: "수락", image: acceptImage, selectedImage: nil)
            let standByItem : UITabBarItem = .init(title: "대기", image: standByImage, selectedImage: nil)
            let refusalItem : UITabBarItem = .init(title: "거절", image: refusalImage, selectedImage: nil)
            let deleteItem : UITabBarItem = .init(title: "삭제", image: deleteImage, selectedImage: nil)
            
            root1.tabBarItem = acceptItem
            root2.tabBarItem = standByItem
            root3.tabBarItem = refusalItem
            root4.tabBarItem = deleteItem
            
            rootViewController.tabBar.tintColor = .bamBoo_57CC4D
            self.rootViewController.setViewControllers([root1,root2,root3,root4], animated: true)
        }
        return .multiple(flowContributors: [
            .contribute(withNextPresentable: acceptFlow,withNextStepper: acceptFlow.stepper),
            .contribute(withNextPresentable: standByFlow,withNextStepper: standByFlow.stepper),
            .contribute(withNextPresentable: refusalFlow,withNextStepper: refusalFlow.stepper),
            .contribute(withNextPresentable: deleteFlow,withNextStepper: deleteFlow.stepper)
        ])
    }
}

