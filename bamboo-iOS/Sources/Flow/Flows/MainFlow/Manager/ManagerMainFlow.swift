//
//  ManagerMainFlow.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/12/06.
//

import UIKit.UINavigationController
import RxSwift
import RxFlow
import UIKit

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
    let rootViewController = UITabBarController().then{
        $0.tabBar.backgroundColor = .white
        $0.tabBar.barTintColor = .white
        $0.tabBar.barStyle = .black
        $0.tabBar.tintColor = .bamBoo_57CC4D
        $0.tabBar.layer.applySketchShadow(color: .bamBoo_57CC4D, alpha: 0.25, x: 1, y: 0, blur: 10, spread: 0)
    }
    private let provider : ServiceProviderType
    private let acceptFlow : AcceptFlow
    private let standByFlow : StandByFlow
    private let refusalFlow : RefusalFlow
    private let deleteFlow : DeleteFlow
    
    init(with provider : ServiceProviderType){
        self.provider = provider
        self.acceptFlow = .init(stepper: .init(), provider: provider)
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
            
            let acceptImage : UIImage? = UIImage(systemName: "circle")?.withRenderingMode(.alwaysTemplate)
            let standByImage : UIImage? = UIImage(systemName: "stop.circle")?.withRenderingMode(.alwaysTemplate)
            let refusalImage : UIImage? = UIImage(systemName: "exclamationmark.circle")?.withRenderingMode(.alwaysTemplate)
            let deleteImage : UIImage? = UIImage(systemName: "trash")?.withRenderingMode(.alwaysTemplate)
            
            let acceptItem : UITabBarItem = .init(title: "수락", image: acceptImage, selectedImage: nil)
            let standByItem : UITabBarItem = .init(title: "대기", image: standByImage, selectedImage: nil)
            let refusalItem : UITabBarItem = .init(title: "거절", image: refusalImage, selectedImage: nil)
            let deleteItem : UITabBarItem = .init(title: "삭제", image: deleteImage, selectedImage: nil)
            
            root1.tabBarItem = acceptItem
            root2.tabBarItem = standByItem
            root3.tabBarItem = refusalItem
            root4.tabBarItem = deleteItem
            [root1,root2,root3,root4].forEach{$0.navigationCustomBar()}
            
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

