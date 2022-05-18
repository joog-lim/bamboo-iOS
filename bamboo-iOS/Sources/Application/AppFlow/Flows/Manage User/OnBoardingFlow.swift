import RxFlow
import RxRelay
import RxSwift
import UIKit

struct OnBoardingStepper: Stepper{
    let steps: PublishRelay<Step> = .init()
    
    var initialStep: Step{
        return BambooStep.onBoardingIsRequired
    }
}

final class OnBoardingFlow: Flow{
    
    // MARK: - Properties
    var root: Presentable{
        return self.rootVC
    }
    
    let stepper: OnBoardingStepper = .init()
    private let rootVC = UINavigationController()
    
    // MARK: - deinit
    deinit {
        print("\(type(of: self)): \(#function)")
    }
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step.asBambooStep else {return .none}
        switch step{
        case .onBoardingIsRequired: 
            return coordinateToOnBoarding()
        case .UserIsRequired:
            return .end(forwardToParentFlowWithStep: BambooStep.UserIsRequired)
        default:
            return.none
        }
    }
}

//MARK: - Method
private extension OnBoardingFlow{
    func coordinateToOnBoarding() -> FlowContributors {
        let vc = AppDelegate.container.resolve(OnBoardingViewController.self)!
        self.rootVC.setViewControllers([vc], animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vc.reactor!))
    }
    
}
