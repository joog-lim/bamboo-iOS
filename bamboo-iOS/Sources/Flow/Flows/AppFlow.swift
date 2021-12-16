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
    private let disposeBag: DisposeBag = .init()
    private let provider: ServiceProviderType
    
    init(provider : ServiceProviderType){
        self.provider = provider
    }
    
    func readyToEmitSteps() {
        steps.accept(BambooStep.LoginIsRequired)
//        provider.loginService.didLoginObservable
//            .map{ $0 ? BambooStep.userIsLoggedIn : BambooStep.userLoginIsRequired}
//            .bind(to: steps)
//            .disposed(by: disposeBag)
    }
}

final class AppFlow : Flow{
    var root: Presentable{
        return self.rootWindow
    }
    private let rootWindow : UIWindow
    private let provider : ServiceProviderType
    
    init(
        with window : UIWindow,
        and services : ServiceProviderType){
            self.rootWindow = window
            self.provider = services
    }
    
    deinit{
        print("\(type(of: self)) : \(#function)")
    }
    
    //1. 바로 메인으로 이동
    //2. 로그인 필요 (관리자, 사용자)
    //3. 로그인 완료
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step.asBambooStep else {return .none}
        switch step{
            //앱 처음 시작하면 로그인이 되어 있지 않을 경우 로그인 화면으로 이동
        case .LoginIsRequired:
            return coordinateToLoginVC()
            //mainTabbarRequired호출시 MainFlow와 nextStep을 넘겨줌
        case .userMainTabBarIsRequired,.userIsLoggedIn:
            return coordinateToUserMainVC()
        case .managerMainTabBarIsRequired , .managerIsLoggedIn :
            return coordinateToManagerVC()
        default:
            return .none
        }
    }
    
    private func coordinateToLoginVC() ->FlowContributors{
        let flow = LoginFlow(with: provider)
        Flows.use(flow, when: .created) { [unowned self] root in
            rootWindow.rootViewController = root
        }
        let nextStep = OneStepper(withSingleStep: BambooStep.LoginIsRequired)
        return .one(flowContributor: .contribute(withNextPresentable: flow, withNextStepper: nextStep))
    }
    private func coordinateToUserMainVC() -> FlowContributors{
        let flow = MainFlow()
        Flows.use(flow, when: .created) { [unowned self] root in
            rootWindow.rootViewController = root
        }
        let nextStep = OneStepper(withSingleStep: BambooStep.userMainTabBarIsRequired)
        
        return .one(flowContributor: .contribute(withNextPresentable: flow, withNextStepper: nextStep))
    }
    private func coordinateToManagerVC() -> FlowContributors{
        let flow = ManagerMainFlow()
        Flows.use(flow, when: .created) { [unowned self] root in
            rootWindow.rootViewController = root
        }
        let nextStep = OneStepper(withSingleStep: BambooStep.managerMainTabBarIsRequired)
        
        return .one(flowContributor: .contribute(withNextPresentable: flow, withNextStepper: nextStep))
    }
}
