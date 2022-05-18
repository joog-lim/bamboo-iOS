import UIKit

import RxFlow
import RxRelay

struct DeleteStepper: Stepper {
    let steps: PublishRelay<Step> = .init()
    
    var initialStep: Step {
        return BambooStep.DeleteIsRequired
    }
}

final class DeleteFlow : Flow{
    //MARK: - Properties
    var root: Presentable {
        return self.rootViewController
    }
    private let rootViewController = UINavigationController()
    let stepper: DeleteStepper = .init()

    deinit {
        print("\(type(of: self)): \(#function)")
    }
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step.asBambooStep else {return .none}
        switch step{
        case .DeleteIsRequired :
            return coordinatorToDelete()
        default: return .none
        }
    }
}

//MARK: - Method
private extension DeleteFlow {
    func coordinatorToDelete() -> FlowContributors{
        let vc = AppDelegate.container.resolve(DeleteViewController.self)!
        let reactor = AppDelegate.container.resolve(DeleteReactor.self)!
        self.rootViewController.setViewControllers([vc], animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc,withNextStepper: reactor))
    }
}
