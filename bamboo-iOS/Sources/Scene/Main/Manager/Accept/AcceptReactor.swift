//
//  AcceptReactor.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/12/06.
//

import UIKit

import ReactorKit
import RxFlow
import RxRelay

final class AcceptReactor : Reactor, Stepper{
    var steps: PublishRelay<Step> = .init()
    
    enum Action{
        case editContentPresent(idx : String, index : Int)
    }
    enum Mutation{
        
    }
    struct State{
        
    }
    
    let initialState: State
    
    let errorSubject: PublishSubject<Error> = .init()

    init(){
        self.initialState = State()
    }

}
extension AcceptReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .editContentPresent(idx,index):
            steps.accept(BambooStep.editContentModalsRequired(idx: idx, index: index))
            return .empty()
        }
    }
}
