import RxFlow
import RxRelay
import RxSwift
import UIKit
import UIUtil

final class UserFlow : Flow{
    
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
        case .UserIsRequired:
            return coordinateToUserTabBar()
        default:
            return .none
        }
    }
    
}
//MARK: - Method
private extension UserFlow{
    private func coordinateToUserTabBar() -> FlowContributors {
        Flows.use(
            [homeFlow, ruleFlow,detailFlow]
            , when: .created
        ) { [unowned self]  root in
            
            let homeItem = UITabBarItem(title: "홈", image: UIImage(systemName: "house"))
            let ruleItem = UITabBarItem(title: "규칙", image: UIImage(systemName: "exclamationmark"))
            let detailItem = UITabBarItem(title: "더보기", image: UIImage(systemName: "ellipsis"))
            
            root[0].tabBarItem = homeItem
            root[1].tabBarItem = ruleItem
            root[2].tabBarItem = detailItem
            self.rootViewController.setViewControllers(root, animated: true)
        }
        return .multiple(flowContributors: [
            .contribute(withNextPresentable: homeFlow,withNextStepper: homeFlow.stepper),
            .contribute(withNextPresentable: ruleFlow,withNextStepper: ruleFlow.stepper),
            .contribute(withNextPresentable: detailFlow,withNextStepper: detailFlow.stepper)
        ])
    }
}
