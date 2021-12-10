//
//  DeleteFlow.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/12/11.
//
import UIKit

import RxFlow
import RxRelay

struct DeleteStepper : Stepper{
    let steps: PublishRelay<Step> = .init()
    
    var initialStep: Step{
        return BambooStep.managerDeleteIsRequired
    }
}

final class DeleteFlow : Flow{
    //MARK: - Properties
    var root: Presentable{
        return self.rootViewController
    }
    let stepper: DeleteStepper
    private let rootViewController = UINavigationController()
    
    //MARK: - Initalizer
    init(stepper : DeleteStepper){
        self.stepper = stepper
    }
    deinit{
        print("\(type(of: self)): \(#function)")
    }
    //MARK: - Navigation
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step.asBambooStep else {return .none}
        
        switch step{
        case.managerDeleteIsRequired:
            return coordinatorToDelete()
        default:
            return.none
        }
    }
    
}

private extension DeleteFlow{
    func coordinatorToDelete() -> FlowContributors{
        let reactor = DeleteReactor()
        let vc = DeleteViewController(reactor: reactor)
        self.rootViewController.setViewControllers([vc], animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc,withNextStepper: reactor))
    }
}

