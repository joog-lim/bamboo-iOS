//
//  LoginFlow.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/12/03.
//

import UIKit
import RxFlow
import RxRelay
import PanModal

final class LoginFlow : Flow{
    //MARK: - Properties
    var root: Presentable{
        return self.rootVC
    }
    
    private let rootVC : UINavigationController = .init()
    private let provider : ServiceProviderType
    
    //MARK: - Init
    init(with services : ServiceProviderType) {
        self.provider = services
    }
    
    deinit{
        print("\(type(of: self)): \(#function)")
    }
    //MARK: - Navigation
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step.asBambooStep else {return .none}
        
        switch step{
        case .LoginIsRequired:
            return coordinateToLoginVC()
        case .userLoginIsRequired,.managerLoginIsRequired:
            return coordinateToLoginModalVC()
        case .otpLoginIsRequired:
            return coordinateToOTPModalVC()
        case .userIsLoggedIn, .guestLoginIsRequired, .userMainTabBarIsRequired:
            return .end(forwardToParentFlowWithStep: BambooStep.userMainTabBarIsRequired)
        case .managerIsLoggedIn ,.managerMainTabBarIsRequired:
            return .end(forwardToParentFlowWithStep: BambooStep.managerMainTabBarIsRequired)
        case .dismiss:
            return dismissVC()
        case .backBtnRequired:
            return navigationPop()
        default :
            return .none
        }
    }
    
    //MARK: - Coordinator
    private func coordinateToLoginVC() -> FlowContributors{
        let reactor = LoginReactor(provider: provider)
        let vc = LoginViewController(reactor: reactor)
        self.rootVC.setViewControllers([vc], animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: reactor))
    }
    
    private func coordinateToLoginModalVC() -> FlowContributors{
        let reactor = OauthModalReactor(with: provider)
        let vc = OauthModalVC(reactor: reactor)
        self.rootVC.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: reactor))
    }
    
    private func coordinateToOTPModalVC() -> FlowContributors{
        let reactor = OTPModalReactor(with: provider)
        let vc = OTPModalVC(reactor: reactor)
        self.rootVC.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: reactor))
    }
    private func navigationPop() -> FlowContributors{
        self.rootVC.popViewController(animated: true)
        return .none
    }
    private func dismissVC() -> FlowContributors{
        self.rootVC.visibleViewController?.dismiss(animated: true)
        return .none
    }
}
