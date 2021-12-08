//
//  LoginFlow.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/12/03.
//

import UIKit
import RxFlow
import RxRelay

final class LoginFlow : Flow{
    //MARK: - Properties
    var root: Presentable{
        return self.rootVC
    }
    
    private let rootVC : UINavigationController = .init()
    
    //MARK: - Init
    init() { }
    
    deinit{
        print("\(type(of: self)): \(#function)")
    }
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step.asBambooStep else {return .none}
        
        switch step{
        case .LoginIsRequired:
            return coordinateToLoginVC()
        case .userLoginIsRequired:
            return coordinateToUserLoginModalVC()
        case .managerLoginIsRequired:
            return coordinateToManagerLoginModalVC()
        case .userIsLoggedIn:
            return .end(forwardToParentFlowWithStep: BambooStep.userMainTabBarIsRequired)
        case .managerIsLoggedIn:
            return .end(forwardToParentFlowWithStep: BambooStep.managerMainTabBarIsRequired)
        case .userMainTabBarIsRequired:
            return .end(forwardToParentFlowWithStep: BambooStep.userMainTabBarIsRequired)
        case .dismiss:
            return dismissVC()
        default :
            return .none
        }
    }
    private func coordinateToLoginVC() -> FlowContributors{
        let reactor = LoginReactor()
        let vc = LoginViewController(reactor: reactor)
        self.rootVC.setViewControllers([vc], animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: reactor))
    }
    
    private func coordinateToUserLoginModalVC() -> FlowContributors{
        let reactor = GoogleOauthModalReactor()
        let vc = GoogleOauthModalVC(reactor: reactor)
        vc.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        vc.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.rootVC.visibleViewController?.present(vc, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: reactor))
    }
    
    private func coordinateToManagerLoginModalVC() -> FlowContributors{
        let reactor = ManagerLoginModalReactor()
        let vc = ManagerLoginModal(reactor: reactor)
        vc.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        vc.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.rootVC.visibleViewController?.present(vc, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: reactor))
    }

    
    private func dismissVC() -> FlowContributors{
        self.rootVC.visibleViewController?.dismiss(animated: true)
        return .none
    }
}
