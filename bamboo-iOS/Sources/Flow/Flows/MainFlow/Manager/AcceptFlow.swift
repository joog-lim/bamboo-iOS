//
//  AcceptFlow.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/12/06.
//

import UIKit
import PanModal
import RxFlow
import RxRelay

struct AcceptStepper : Stepper{
    let steps: PublishRelay<Step> = .init()
    
    var initialStep: Step{
        return BambooStep.managerAcceptIsRequired
    }
}

final class AcceptFlow : Flow{
    //MARK: - Properties
    var root: Presentable{
        return self.rootViewController
    }
    let stepper: AcceptStepper
    private let rootViewController = UINavigationController()
    
    //MARK: - Initalizer
    init(stepper : AcceptStepper){
        self.stepper = stepper
    }
    deinit{
        print("\(type(of: self)): \(#function)")
    }
    //MARK: - Navigation
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step.asBambooStep else {return .none}
        
        switch step{
        case .backBtnRequired:
            return coordinateToBack()
        case.managerAcceptIsRequired:
            return coordinatorToAccess()
        case let .editContentModalsRequired(idx,index):
            return coordinatorToEditContent(idx: idx,index : index)
        case .dismiss:
            return dismissVC()
        default:
            return.none
        }
    }
}

private extension AcceptFlow{
    func coordinatorToAccess() -> FlowContributors{
        let reactor = AcceptReactor()
        let vc = AcceptViewController(reactor: reactor)
        self.rootViewController.setViewControllers([vc], animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc,withNextStepper: reactor))
    }
    func coordinatorToEditContent(idx : Int, index : Int) -> FlowContributors{
        let reactor = EditContentModalReactor()
        let vc = EditContentModal(reactor: reactor)
        vc.modalPresentationStyle = .custom
        vc.modalPresentationCapturesStatusBarAppearance = true
        vc.transitioningDelegate = PanModalPresentationDelegate.default
        rootViewController.present(vc, animated: true, completion: nil)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: reactor))
    }
    func coordinateToBack() -> FlowContributors{
        self.rootViewController.navigationController?.popViewController(animated: true)
        return .none
    }
    private func dismissVC() -> FlowContributors{
        self.rootViewController.visibleViewController?.dismiss(animated: true)
        return .none
    }
}
