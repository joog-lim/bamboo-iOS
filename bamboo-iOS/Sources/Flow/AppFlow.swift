//
//  AppFlow.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/12/02.
//

import UIKit

import RxFlow
import RxCocoa
import RxSwift

struct AppStepper : Stepper{
    let steps: PublishRelay<Step> = .init()
    
    func readyToEmitSteps() {
        steps.accept(BambooStep.LoginIsRequired)
    }
}

final class AppFlow : Flow{
    var root: Presentable{
        return self.rootWindow
    }
    private let rootWindow : UIWindow
    
    init(with window : UIWindow){
        self.rootWindow = window
    }
    
    deinit{
        NSLog("\(type(of: self)) : \(#function)")
    }
    
    //1. 바로 메인으로 이동
    //2. 로그인 필요 (관리자, 사용자)
    //3. 로그인 완료
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step.asBambooStep else {return .none}
        switch step{
        case .LoginIsRequired:
            return coordinateToUserLoginVC()
        default:
            return .none
        }
    }
    
    private func coordinateToUserLoginVC() ->FlowContributors{
        let flow = LoginFlow(stepper: .init())
        Flows.use(flow, when: .created) { [unowned self] root in
            rootWindow.rootViewController = root
        }
        let nextStep = OneStepper(withSingleStep: BambooStep.LoginIsRequired)
        return .one(flowContributor: .contribute(withNextPresentable: flow, withNextStepper: nextStep))
    }
}
