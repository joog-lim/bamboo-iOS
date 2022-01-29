//
//  DeleteFlow.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/12/11.
//
import UIKit
import PanModal

import RxFlow
import RxRelay

struct DeleteStepper : Stepper{
    let steps: PublishRelay<Step> = .init()
    
    var initialStep: Step{
        return BambooStep.managerDeleteIsRequired
    }
}

final class DeleteFlow : Flow{
    //MARK: - Properties
    var root: Presentable{
        return self.rootViewController
    }
    
    let provider : ServiceProviderType
    let stepper: DeleteStepper
    let reactor : DeleteReactor 
    private let rootViewController = UINavigationController()
    
    //MARK: - Initalizer
    init(
        stepper : DeleteStepper,
        provider : ServiceProviderType
    ){
        self.stepper = stepper
        self.provider = provider
        self.reactor = .init(provider: provider)
    }
    deinit{
        print("\(type(of: self)): \(#function)")
    }
    //MARK: - Navigation
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step.asBambooStep else {return .none}
        
        switch step{
        case.managerDeleteIsRequired:
            return coordinatorToDelete()
        case let .alert(titleText, message, idx,index,algorithmNumber):
            return navigateToAlertScreen(titleText: titleText, message: message, idx: idx, index: index, algorithmNumber: algorithmNumber)
        case let .refusalRequired(idx,algorithmNumber,index):
            return coordinatorToRefusalModalRequired(idx: idx,algorithmNumber: algorithmNumber ,index: index)
        case .dismiss:
            return dismissVC()
        default:
            return.none
        }
    }
    
}

private extension DeleteFlow{
    func coordinatorToDelete() -> FlowContributors{
        let vc = DeleteViewController(reactor: reactor)
        self.rootViewController.setViewControllers([vc], animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc,withNextStepper: reactor))
    }
    func navigateToAlertScreen(titleText : String, message : String, idx : Int, index : Int,algorithmNumber : Int) -> FlowContributors{
        let alert = UIAlertController(title: titleText, message: message, preferredStyle: .alert)
        alert.addAction(.init(title: "거절", style: .default,handler: { _ in
            _ = self.reactor.mutate(action: .alertRefusalTap(idx, algorithmNumber, index))
        }))
        alert.addAction(.init(title: "삭제", style: .destructive, handler: {_ in
            self.reactor.action.onNext(.alertDeleteTap(idx, index))
        }))
        rootViewController.present(alert, animated: true)
        return .none
    }
    func coordinatorToRefusalModalRequired(idx : Int, algorithmNumber : Int,index :Int) -> FlowContributors{
        let reactor = RefusalModalReactor(provider: provider, idx: idx, algorithmNumber: algorithmNumber, index: index)
        let vc = RefusalModal(reactor: reactor)
        vc.modalPresentationStyle = .custom
        vc.modalPresentationCapturesStatusBarAppearance = true
        vc.transitioningDelegate = PanModalPresentationDelegate.default
        rootViewController.present(vc, animated: true, completion: nil)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: reactor))
    }
    
    private func dismissVC() -> FlowContributors{
        self.rootViewController.visibleViewController?.dismiss(animated: true)
        return .none
    }
}

