//
//  DetailFlow.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/12/06.
//

import UIKit

import RxFlow
import RxRelay

struct DetailStepper : Stepper{
    let steps: PublishRelay<Step> = .init()
    
    var initialStep: Step{
        return BambooStep.detailIsRequired
    }
}

final class DetailFlow : Flow{
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
            return coordinatorToDetail()
        default:
            return.none
        }
    }
    
}

private extension DetailFlow{
    func coordinatorToDetail() -> FlowContributors{
        return .none
    }
}

