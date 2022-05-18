import RxFlow
import RxRelay
import RxSwift
import UIKit

struct AppStepper: Stepper{
    let steps: PublishRelay<Step> = .init()
    private let disposeBag: DisposeBag = .init()
    
    func readyToEmitSteps() {
        steps.accept(BambooStep.onBoardingIsRequired)
    }
}

final class AppFlow: Flow{

    
    // MARK: - Properties
    var root: Presentable{
        return self.rootVC
    }
    
    private lazy var rootVC: UIViewController = {
        let launchScreenStoryboard = UIStoryboard(name: "LaunchScreen", bundle: nil)
        let launchScreen = launchScreenStoryboard.instantiateViewController(withIdentifier: "LaunchScreen")
        return launchScreen
    }()
    
    // MARK: - deinit
    deinit{
        print("\(type(of: self)): \(#function)")
    }
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step.asBambooStep else { return .none }
        switch step{
        case .onBoardingIsRequired:
            return coordinateToUserManage()
        case .UserIsRequired:
            return coordinateToUserService()
        case .ManagerIsRequired:
            return coordinateToManagerService()
        default:
            return .none
        }
    }
}


//MARK: - Method
private extension AppFlow{
    func coordinateToUserManage() -> FlowContributors{
        let flow = OnBoardingFlow()
        Flows.use(
            flow,
            when: .created
        ) { [unowned self] root in
            root.modalPresentationStyle = .fullScreen
            root.modalTransitionStyle = .crossDissolve
            DispatchQueue.main.async {
                self.rootVC.dismiss(animated: false)
                self.rootVC.present(root, animated: true)
            }
        }
        return.one(flowContributor: .contribute(
            withNextPresentable: flow,
            withNextStepper: OneStepper(withSingleStep: BambooStep.onBoardingIsRequired)
        ))
    }
    
    func coordinateToUserService() -> FlowContributors{
        let flow = UserFlow()
        Flows.use(
            flow,
            when: .created
        ) { [unowned self] root in
            root.modalPresentationStyle = .fullScreen
            root.modalTransitionStyle = .crossDissolve
            DispatchQueue.main.async {
                self.rootVC.dismiss(animated: false)
                self.rootVC.present(root, animated: true)
            }
        }
        return .one(
            flowContributor: .contribute(
                withNextPresentable: flow,
                withNextStepper: OneStepper(withSingleStep: BambooStep.UserIsRequired)
            ))
    }
    
    func coordinateToManagerService() -> FlowContributors{
        let flow = ManagerFlow()
        Flows.use(
            flow,
            when: .created
        ) { [unowned self] root in
            root.modalPresentationStyle = .fullScreen
            root.modalTransitionStyle = .crossDissolve
            DispatchQueue.main.async {
                self.rootVC.dismiss(animated: false)
                self.rootVC.present(root, animated: true)
            }
        }
        return .one(
            flowContributor: .contribute(
                withNextPresentable: flow,
                withNextStepper: OneStepper(withSingleStep: BambooStep.ManagerIsRequired)
            ))
    }
}
