//
//  LoginFlow.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/12/03.
//

import UIKit
import RxFlow
import RxRelay

struct LoginStepper : Stepper{
    let steps: PublishRelay<Step> = .init()
    
    var initialStep: Step{
        return BambooStep.LoginIsRequired
    }
}

final class LoginFlow : Flow{
    //MARK: - Properties
    var root: Presentable{
        return self.rootVC
    }
    
    let stepper : LoginStepper
    private let rootVC : UINavigationController = .init()
    
    //MARK: - Init
    init(stepper : LoginStepper){
        self.stepper = stepper
    }
    
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step.asBambooStep else {return .none}
        switch step{
        case .LoginIsRequired:
            return coordinateToLoginVC()
        case .userLoginIsRequired:
            return coordinateToUserLoginModalVC()
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
//        vc.preferredContentSize = CGSize(width: UIScreen.main.bounds.width, height: 500)
        self.rootVC.visibleViewController?.present(vc, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: reactor))
    }
    
    private func dismissVC() -> FlowContributors{
        self.rootVC.visibleViewController?.dismiss(animated: true)
        return .none
    }
}
