import RxFlow
import RxRelay
import RxSwift
import UIKit
import UIUtil

final class ManagerFlow : Flow{
    
    enum TabIndex: Int {
        case accept = 0
        case standBy = 1
        case refusal = 2
        case delete = 3
    }
    var root: Presentable {
        return self.rootViewController
    }
    
    let rootViewController: UITabBarController = .init()
    private let accpetFlow :  AcceptFlow = .init()
    private let standByFlow : StandByFlow = .init()
    private let refusalFlow : RefusalFlow = .init()
    private let deleteFlow : DeleteFlow = .init()
    
    //MARK: - deinit
    deinit {
        print("\(type(of: self)): \(#function)")
    }
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step.asBambooStep else {return .none}
        switch step{
        case .onBoardingIsRequired:
            return .end(forwardToParentFlowWithStep: BambooStep.onBoardingIsRequired)
        case .ManagerIsRequired:
            return coordinateToManagerTabBar()
        default:
            return .none
        }
    }
    
}
//MARK: - Method
private extension ManagerFlow{
    private func coordinateToManagerTabBar() -> FlowContributors {
        Flows.use(
            [accpetFlow, standByFlow,refusalFlow,deleteFlow],
            when: .created
        ) { [unowned self]  root in
            
            let acceptItem = UITabBarItem(title: "수락", image: UIImage(systemName: "lock.open"))
            let standByItem = UITabBarItem(title: "대기", image: UIImage(systemName: "stop.circle"))
            let refusalItem = UITabBarItem(title: "거절", image: UIImage(systemName: "exclamationmark.triangle"))
            let deleteItem = UITabBarItem(title: "삭제", image: UIImage(systemName: "trash"))
            
            root[0].tabBarItem = acceptItem
            root[1].tabBarItem = standByItem
            root[2].tabBarItem = refusalItem
            root[3].tabBarItem = deleteItem
            
            self.rootViewController.setViewControllers(root, animated: true)
        }
        return .multiple(flowContributors: [
            .contribute(withNextPresentable: accpetFlow,withNextStepper: accpetFlow.stepper),
            .contribute(withNextPresentable: standByFlow,withNextStepper: standByFlow.stepper),
            .contribute(withNextPresentable: refusalFlow,withNextStepper: refusalFlow.stepper),
            .contribute(withNextPresentable: deleteFlow,withNextStepper: deleteFlow.stepper)
        ])
    }
}
