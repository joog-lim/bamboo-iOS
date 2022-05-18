//
//  HomeFlow.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2022/05/18.
//

import UIKit

import RxFlow
import RxRelay

struct HomeStepper: Stepper {
    let steps: PublishRelay<Step> = .init()
    
    var initialStep: Step {
        return BambooStep.HomeIsRequired
    }
}

final class HomeFlow : Flow{
    //MARK: - Properties
    var root: Presentable {
        return self.rootViewController
    }
    private let rootViewController = UINavigationController()
    let stepper: HomeStepper = .init()

    deinit {
        print("\(type(of: self)): \(#function)")
    }
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step.asBambooStep else {return .none}
        switch step{
        case .HomeIsRequired :
            return .none
        default: return .none
        }
    }
}

//MARK: - Method
private extension HomeFlow {
    
}
