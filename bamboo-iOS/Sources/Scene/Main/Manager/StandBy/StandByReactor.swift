//
//  StandByReactor.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/12/11.
//

import UIKit

import ReactorKit
import RxFlow
import RxRelay

final class StandByReactor : Reactor, Stepper{
    var steps: PublishRelay<Step> = .init()
    
    enum Action{
        case standbyBtnTap(titleText : String, message : String, idx : String, index : Int)
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

extension StandByReactor{
    func mutate(action: Action) -> Observable<Mutation> {
        switch action{
        case let .standbyBtnTap(titleText, message,idx,index):
            steps.accept(BambooStep.standByAndAlertIsRequired(titleText: titleText, message: message, idx: idx, index: index))
            return .empty()
        }
    }
}
