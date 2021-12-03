//
//  UserLoginStepper.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/12/02.
//

import UIKit
import RxFlow
import RxRelay

//struct UserLoginStepper: Stepper{
//    let steps: PublishRelay<Step> = .init()
//    
//    var initialStep: Step{
//        return BambooStep.userLoginIsRequired
//    }
//}
//
//final class UserLoginFlow : Flow{
//    //MARK: - Properties
//    var root: Presentable{
//        return self.rootVC
//    }
//    
//    private let stepper : UserLoginStepper
//    private let rootVC : UINavigationController = .init()
//    
//    init(stepper : UserLoginStepper){
//        self.stepper = stepper
//    }
//    
//    
//    func navigate(to step: Step) -> FlowContributors {
//        guard let step = step.asBambooStep else {return .none}
//        switch step {
//        case .dismiss:
//            return dismissVC()
////        case .UserLoginisRequired:
////        case .ManagerLoginIsRequired
//        default:
//            return .none
//        }
//        
//    }
//    private func dismissVC() -> FlowContributors{
//        self.rootVC.visibleViewController?.dismiss(animated: true)
//        return .none
//    }
//    
//}
