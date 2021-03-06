//
//  HomeFlow.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/12/06.
//

import UIKit
import RxFlow
import RxRelay
import PanModal

struct HomeStepper : Stepper{
    let steps: PublishRelay<Step> = .init()
    
    var initialStep: Step{
        return BambooStep.homeIsRequired
    }
}

final class HomeFlow : Flow{
    //MARK: - Properties
    var root: Presentable{
        return self.rootViewController
    }
    let stepper: HomeStepper
    private let rootViewController = UINavigationController()
    private let provider : ServiceProviderType
    
    //MARK: - Initalizer
    init(
        stepper : HomeStepper,
        with services : ServiceProviderType
    ){
        self.stepper = stepper
        self.provider = services
    }
    deinit{
        print("\(type(of: self)): \(#function)")
    }
    //MARK: - Navigation
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step.asBambooStep else {return .none}
        switch step{
        case.homeIsRequired:
            return coordinatorToHome()
        case .writeModalIsRequired:
            return coordinatorWriteModal()
        case let .reportModalsRequired(idx,index):
            return coordinatorReportModal(idx: idx, index: index)
        case.dismiss:
            return dismissVC()
        default:
            return.none
        }
    }
}

private extension HomeFlow{
    func coordinatorToHome() -> FlowContributors{
        let reactor = MainReactor(provider: provider)
        let vc = MainViewController(reactor: reactor)
        self.rootViewController.setViewControllers([vc], animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc,withNextStepper: reactor))
    }
    
    func coordinatorWriteModal() -> FlowContributors{
        let reactor = WritingBulletinBoardReactor(with: provider)
        let vc = WritingBulletinBoardModal(reactor: reactor)
        vc.modalPresentationStyle = .custom
        vc.modalPresentationCapturesStatusBarAppearance = true
        vc.transitioningDelegate = PanModalPresentationDelegate.default
        rootViewController.present(vc, animated: true, completion: nil)
        return .one(flowContributor: .contribute(withNextPresentable: vc,withNextStepper: reactor))
    }
    
    func coordinatorReportModal(idx : Int,index : Int) -> FlowContributors{
        let reactor = ReportReactor(provider: provider, idx: idx)
        let vc =  ReportModal(reactor: reactor)
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
