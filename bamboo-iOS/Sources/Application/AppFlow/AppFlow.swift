import RxFlow
import RxRelay
import RxSwift
import UIKit

struct AppStepper: Stepper{
    let steps: PublishRelay<Step> = .init()
    private let disposeBag: DisposeBag = .init()
    
    func readyToEmitSteps() {
        steps.accept(BambooStep.loginIsRequired)
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
        switch step{
        default:
            return .none
        }
    }
}


//MARK: - Method
private extension AppFlow{
    
}