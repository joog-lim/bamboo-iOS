//
//  ReportReactor.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/12/16.
//

import ReactorKit
import RxFlow
import RxCocoa

final class ReportReactor: Reactor , Stepper{
    
    var disposeBag : DisposeBag = .init()
    
    var steps: PublishRelay<Step> = .init()
    
    enum Action{
        case dismissModal
        case reportBtnTap
    }
    enum Mutation{
        
    }
    struct State{
        
    }
    
    let initialState: State
    let idx : Int
    
    init(provider : ServiceProviderType, idx: Int){
        self.initialState = State()
        self.idx = idx
    }
}

extension ReportReactor{
    func mutate(action: Action) -> Observable<Mutation> {
        switch action{
        case.dismissModal:
            steps.accept(BambooStep.dismiss)
            return .empty()
        case .reportBtnTap:
            return .empty()
        }
    }
}
