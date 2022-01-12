//
//  RuleFlow.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/12/06.
//

import UIKit

import RxFlow
import RxRelay

struct RuleStepper : Stepper{
    let steps: PublishRelay<Step> = .init()
    
    var initialStep: Step{
        return BambooStep.ruleIsRequired
    }
}

final class RuleFlow : Flow{
    //MARK: - Properties
    var root: Presentable{
        return self.rootViewController
    }
    let stepper: RuleStepper
    private let rootViewController = UINavigationController()
    private let provider : ServiceProviderType
    
    //MARK: - Initalizer
    init(
        stepper : RuleStepper,
        with services: ServiceProviderType
    ){
        self.stepper = stepper
        self.provider = services
    }
    deinit{
        print("\(type(of: self)): \(#function)")
    }
    //MARK: - Navigation
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step.asBambooStep else {return .none}
        
        switch step{
        case .ruleIsRequired:
            return coordinatorToRule()
        default:
            return.none
        }
    }
}

private extension RuleFlow{
    func coordinatorToRule() -> FlowContributors{
        let reactor = RuleReactor(with: provider)
        let vc = RuleViewController(reactor: reactor)
        self.rootViewController.setViewControllers([vc], animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc,withNextStepper: reactor))
    }
}
