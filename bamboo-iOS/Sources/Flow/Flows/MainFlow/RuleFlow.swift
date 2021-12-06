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
    let stepper: HomeStepper
    private let rootViewController = UINavigationController()
    
    //MARK: - Initalizer
    init(stepper : HomeStepper){
        self.stepper = stepper
    }
    deinit{
        print("\(type(of: self)): \(#function)")
    }
    //MARK: - Navigation
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step.asBambooStep else {return .none}
        
        switch step{
        case.homeIsRequired:
            return coordinatorToRule()
        default:
            return.none
        }
    }
    
}

private extension RuleFlow{
    func coordinatorToRule() -> FlowContributors{
        return .none
    }
}
