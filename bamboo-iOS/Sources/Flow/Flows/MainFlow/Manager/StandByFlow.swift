//
//  StandByFlow.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/12/07.
//

import UIKit

import RxFlow
import RxRelay

struct StandByStepper : Stepper{
    let steps: PublishRelay<Step> = .init()
    
    var initialStep: Step{
        return BambooStep.managerAcceptIsRequired
    }
}

final class StandByFlow : Flow{
    //MARK: - Properties
    var root: Presentable{
        return self.rootViewController
    }
    let stepper: StandByStepper
    private let rootViewController = UINavigationController()
    
    //MARK: - Initalizer
    init(stepper : StandByStepper){
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
            return coordinatorToHome()
        default:
            return.none
        }
    }
    
}

private extension StandByFlow{
    func coordinatorToHome() -> FlowContributors{
        return .none
    }
}
