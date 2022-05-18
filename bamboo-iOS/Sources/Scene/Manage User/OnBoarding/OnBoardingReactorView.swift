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
        // actiom cases
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
        // switch action {
        // }
    }
}

//MARK: - reduce
extension OnBoardingReactor {
    func reduce(state: State, mutation: Mutation) -> State {
        let newState = state
        // switch mutation {
        // }
        return newState
    }
}
