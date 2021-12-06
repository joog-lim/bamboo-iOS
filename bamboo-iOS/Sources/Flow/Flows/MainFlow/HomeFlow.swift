//
//  HomeFlow.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/12/06.
//

import UIKit

import RxFlow
import RxRelay

struct HomeStepper : Stepper{
    let steps: PublishRelay<Step> = .init()
    
    var initialStep: Step{
        return BambooStep.homeIsRequired
    }
}

final class HomeFlow : Flow{
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
            return coordinatorToHome()
        default:
            return.none
        }
    }
    
}

private extension HomeFlow{
    func coordinatorToHome() -> FlowContributors{
        return .none
    }
}
