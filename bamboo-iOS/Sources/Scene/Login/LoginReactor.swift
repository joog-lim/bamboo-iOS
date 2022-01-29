//
//  LoginReactor.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/12/02.
//

import ReactorKit
import RxCocoa
import RxFlow
import GoogleSignIn

final class LoginReactor : Reactor, Stepper{
    
    //MARK: - Properties
    var disposeBag : DisposeBag = .init()
    
    //MARK: - Stepper
    var steps: PublishRelay<Step> = .init()
    //MARK: - represent user action(유저 액션을 나타냄)
    enum Action{
        case userLoginButtonDidTap
        case managerLoginButtonDidTap
        case guestLoginButtonDidTap
    }
    
    enum Mutation{
        
    }
    
    struct State{

    }
    
    let initialState: State
    let provider : ServiceProviderType
    
    init(provider : ServiceProviderType){
        self.provider = provider
        self.initialState = State()
    }
    
}
//MARK: - Extension

extension LoginReactor{
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
            //userLogin
        case .userLoginButtonDidTap:
            provider.loginService.didLoginObservable
                .map{ $0 ? BambooStep.userIsLoggedIn : BambooStep.userLoginIsRequired}
                .bind(to: steps)
                .disposed(by: disposeBag)
            return .empty()
            //managerLogin
        case .managerLoginButtonDidTap:
            provider.loginService.isAdminObservable
                .map{ $0 ? BambooStep.managerIsLoggedIn : BambooStep.managerLoginIsRequired}
                .bind(to: steps)
                .disposed(by: disposeBag)
            return .empty()
            //guestLogin
        case .guestLoginButtonDidTap:
            GoogleLogin.shared.SignOutOauth()
            steps.accept(BambooStep.userMainTabBarIsRequired)
            return .empty()
        }
    }
}
