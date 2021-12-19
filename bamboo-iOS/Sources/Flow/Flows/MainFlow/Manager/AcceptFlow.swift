//
//  AcceptFlow.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/12/06.
//

import UIKit

import RxFlow
import RxRelay

struct AcceptStepper : Stepper{
    let steps: PublishRelay<Step> = .init()
    
    var initialStep: Step{
        return BambooStep.managerAcceptIsRequired
    }
}

final class AcceptFlow : Flow{
    //MARK: - Properties
    var root: Presentable{
        return self.rootViewController
    }
    let stepper: AcceptStepper
    private let rootViewController = UINavigationController()
    
    //MARK: - Initalizer
    init(stepper : AcceptStepper){
        self.stepper = stepper
    }
    deinit{
        print("\(type(of: self)): \(#function)")
    }
    //MARK: - Navigation
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step.asBambooStep else {return .none}
        
        switch step{
        case.managerAcceptIsRequired:
            return coordinatorToAccess()
        default:
            return.none
        }
    }
}

private extension AcceptFlow{
    func coordinatorToAccess() -> FlowContributors{
        let reactor = AcceptReactor()
        let vc = AcceptViewController(reactor: reactor)
        self.rootViewController.setViewControllers([vc], animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc,withNextStepper: reactor))
    }
}
