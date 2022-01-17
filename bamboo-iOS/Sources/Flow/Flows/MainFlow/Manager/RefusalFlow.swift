//
//  RefusalFlow.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/12/09.
//

import UIKit

import RxFlow
import RxRelay

struct RefusalStepper : Stepper{
    let steps: PublishRelay<Step> = .init()
    
    var initialStep: Step{
        return BambooStep.managerRefusalIsRequired
    }
}

final class RefusalFlow : Flow{
    //MARK: - Properties
    var root: Presentable{
        return self.rootViewController
    }
    let provider : ServiceProviderType
    let stepper: RefusalStepper
    private let rootViewController = UINavigationController()
    
    //MARK: - Initalizer
    init(stepper : RefusalStepper, provider : ServiceProviderType){
        self.stepper = stepper
        self.provider = provider
    }
    deinit{
        print("\(type(of: self)): \(#function)")
    }
    //MARK: - Navigation
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step.asBambooStep else {return .none}
        
        switch step{
        case.managerRefusalIsRequired:
            return coordinatorToRefusal()
        default:
            return.none
        }
    }
}

private extension RefusalFlow{
    func coordinatorToRefusal() -> FlowContributors{
        let reactor = RefusalReactor(provider: provider)
        let vc = RefusalViewController(reactor: reactor)
        self.rootViewController.setViewControllers([vc], animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc,withNextStepper: reactor))
    }
}
