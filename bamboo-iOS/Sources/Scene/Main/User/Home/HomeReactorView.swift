//
//  HomeReactorView.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2022/05/18.
//

import Foundation
import ReactorKit
import RxSwift

final class HomeReactor: Reactor {
    
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
extension HomeReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        // switch action {
        // }
    }
}

//MARK: - reduce
extension HomeReactor {
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        // switch mutation {
        // }
        return newState
    }
}
