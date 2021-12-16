//
//  DeleteReactor.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/12/11.
//

import UIKit

import ReactorKit
import RxFlow
import RxRelay

final class DeleteReactor : Reactor, Stepper{
    var steps: PublishRelay<Step> = .init()
    
    enum Action{
        case leftNavigationBtnTap
        case rightNavigationBtnTap
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
    deinit{
        print("\(type(of: self)): \(#function)")
    }
}

extension DeleteReactor{
    func mutate(action: Action) -> Observable<Mutation> {
        switch action{
        case .leftNavigationBtnTap:
            steps.accept(BambooStep.LoginIsRequired)
            return .empty()
        case .rightNavigationBtnTap:
//            steps.accept(<#T##event: Step##Step#>)
            return .empty()
        }
    }
}
