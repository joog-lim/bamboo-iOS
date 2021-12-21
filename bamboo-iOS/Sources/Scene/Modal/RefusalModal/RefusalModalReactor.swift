//
//  RefusalModalReactor.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/12/19.
//

import ReactorKit
import RxFlow
import RxCocoa

final class RefusalModalReactor : Reactor,Stepper{

    var disposeBag : DisposeBag = .init()

    var steps: PublishRelay<Step> = .init()
    
    enum Action{
        case alertRefusalTap(idx : String, index : Int)
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
extension RefusalModalReactor{
    func mutate(action: Action) -> Observable<Mutation> {
        switch action{
        case let .alertRefusalTap(idx,index):
            print("실행")
            print(idx)
            steps.accept(BambooStep.refusalRequired(idx: idx, index: index))
            return .empty()
        }
    }
}
