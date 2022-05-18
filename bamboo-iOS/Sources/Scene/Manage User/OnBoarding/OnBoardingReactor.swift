//
//  OnBoardingReactorView.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2022/05/18.
//

import Foundation
import ReactorKit
import RxSwift
import RxFlow
import RxRelay

final class OnBoardingReactor: Reactor ,Stepper{
    // MARK: - Properties
    var steps: PublishRelay<Step> = .init()
    private let disposeBag: DisposeBag = .init()
    
    //MARK: - Reactor
    enum Action {
        case userLoginButtonDidTap
         case managerLoginButtonDidTap
         case guestLoginButtonDidTap
    }
    
    enum Mutation {
        // mutation cases
    }
    
    struct State {
        //state
    }
    
    let initialState: State
    
    init() {
        initialState = State()
    }

}

//MARK: - Mutate
extension OnBoardingReactor {
    func mutate(action: Action) -> Observable<Mutation> {
         switch action {
         case .userLoginButtonDidTap:
             steps.accept(BambooStep.UserIsRequired)
             return .empty()
         case .managerLoginButtonDidTap:
             steps.accept(BambooStep.ManagerIsRequired)
             return .empty()
         case .guestLoginButtonDidTap:
             steps.accept(BambooStep.UserIsRequired)
             return .empty()
         }
    }
}
