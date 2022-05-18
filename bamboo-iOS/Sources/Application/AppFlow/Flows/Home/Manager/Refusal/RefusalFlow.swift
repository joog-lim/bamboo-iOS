import UIKit

import RxFlow
import RxRelay

struct RefusalStepper: Stepper {
    let steps: PublishRelay<Step> = .init()
    
    var initialStep: Step {
        return BambooStep.RefusalIsRequired
    }
}

final class RefusalFlow : Flow{
    //MARK: - Properties
    var root: Presentable {
        return self.rootViewController
    }
    private let rootViewController = UINavigationController()
    let stepper: RefusalStepper = .init()

    deinit {
        print("\(type(of: self)): \(#function)")
    }
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step.asBambooStep else {return .none}
        switch step{
        case .RefusalIsRequired :
            return coordinatorToRefusal()
        default: return .none
        }
    }
}

//MARK: - Method
private extension RefusalFlow {
    func coordinatorToRefusal() -> FlowContributors{
        let vc = AppDelegate.container.resolve(RefusalViewController.self)!
        let reactor = AppDelegate.container.resolve(RefusalReactor.self)!
        self.rootViewController.setViewControllers([vc], animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc,withNextStepper: reactor))
    }
}
