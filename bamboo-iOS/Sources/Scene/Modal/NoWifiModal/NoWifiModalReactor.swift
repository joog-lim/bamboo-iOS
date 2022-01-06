//
//  NoWifiModalReactor.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2022/01/05.
//

import ReactorKit
import RxFlow
import RxCocoa

final class NoWifiModalReactor : Reactor , Stepper{
    var disposeBag : DisposeBag = .init()
    
    var steps: PublishRelay<Step> = .init()
    
    enum Action{
        case timerStart
    }
    enum Mutation{
        case setTimer
    }
    struct State{
        
    }
    let initialState: State
    
    init(){
        self.initialState = State()
    }
}

//MARK: - Mutation
extension NoWifiModalReactor{
    func mutate(action: Action) -> Observable<Action> {
        switch action{
        case .timerStart:
            
            return .empty()
        }
    }
}

//MARK: - Reduce
extension NoWifiModalReactor{
    func reduce(state: State, mutation: Action) -> State {
        let newState = state
        switch mutation{
        case .timerStart:
            _ = fetchTime()
        }
        return newState
    }
}

//MARK: - Method
private extension NoWifiModalReactor{
    func fetchTime() -> Observable<Mutation>{
        return .never()
    }
}
