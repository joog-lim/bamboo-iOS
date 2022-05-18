import RxFlow
import RxRelay
import RxSwift
import UIKit
import UIUtil

final class ManagerFlow : Flow{
    
    enum TabIndex: Int {
        case home = 0
        case rule = 1
        case detail = 2
    }
    var root: Presentable {
        return self.rootViewController
    }
    
    let rootViewController: UITabBarController = .init()
    private let homeFlow :  HomeFlow = .init()
    private let ruleFlow : RuleFlow = .init()
    private let detailFlow : DetailFlow = .init()
    
    //MARK: - deinit
    deinit {
        print("\(type(of: self)): \(#function)")
    }
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step.asBambooStep else {return .none}
        switch step{
        case .onBoardingIsRequired:
            return .end(forwardToParentFlowWithStep: BambooStep.onBoardingIsRequired)
        default:
            return .none
        }
    }
    
}
//MARK: - Method
private extension UserFlow{
 
}
