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

    init(){
        self.initialState = State()
    }
    
}
//MARK: - Extension

extension LoginReactor{
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .userLoginButtonDidTap:
            steps.accept(BambooStep.userIsLoggedIn)
            return .empty()
        case .managerLoginButtonDidTap:
            steps.accept(BambooStep.managerLoginIsRequired)
            return .empty()
        case .guestLoginButtonDidTap:
            steps.accept(BambooStep.userMainTabBarIsRequired)
            return .empty()
        }
    }
}
