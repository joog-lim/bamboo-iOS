import UIKit

import RxFlow
import RxRelay

struct StandByStepper: Stepper {
    let steps: PublishRelay<Step> = .init()
    
    var initialStep: Step {
        return BambooStep.StandByIsRequired
    }
}

final class StandByFlow : Flow{
    //MARK: - Properties
    var root: Presentable {
        return self.rootViewController
    }
    private let rootViewController = UINavigationController()
    let stepper: StandByStepper = .init()

    deinit {
        print("\(type(of: self)): \(#function)")
    }
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step.asBambooStep else {return .none}
        switch step{
        case.StandByIsRequired:
            return coordinatorToStandBy()
        default: return .none
        }
    }
}

//MARK: - Method
private extension StandByFlow {
    func coordinatorToStandBy() -> FlowContributors{
        let vc = AppDelegate.container.resolve(StandByViewController.self)!
        let reactor = AppDelegate.container.resolve(StandByReactor.self)!
        self.rootViewController.setViewControllers([vc], animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc,withNextStepper: reactor))
    }
}
