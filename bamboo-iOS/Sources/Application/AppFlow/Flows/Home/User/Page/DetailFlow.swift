//
//  DetailFlow.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2022/05/18.
//

import UIKit

import RxFlow
import RxRelay

struct DetailStepper: Stepper {
    let steps: PublishRelay<Step> = .init()
    
    var initialStep: Step {
        return BambooStep.DetailIsRequired
    }
}

final class DetailFlow : Flow{
    //MARK: - Properties
    var root: Presentable {
        return self.rootViewController
    }
    private let rootViewController = UINavigationController()
    let stepper: DetailStepper = .init()

    deinit {
        print("\(type(of: self)): \(#function)")
    }
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step.asBambooStep else {return .none}
        switch step{
        case .DetailIsRequired :
            return coordinatorToDetail()
        default: return .none
        }
    }
}

//MARK: - Method
private extension DetailFlow {
    func coordinatorToDetail() -> FlowContributors{
        let vc = AppDelegate.container.resolve(DetailViewController.self)!
        let reactor = AppDelegate.container.resolve(DetailReactor.self)!
        self.rootViewController.setViewControllers([vc], animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc,withNextStepper: reactor))
    }
}
