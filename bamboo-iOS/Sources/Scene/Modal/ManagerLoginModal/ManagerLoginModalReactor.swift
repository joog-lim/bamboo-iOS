//
//  ManagerLoginModalReactor.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/12/04.
//

import ReactorKit
import RxFlow
import RxCocoa

final class ManagerLoginModalReactor: Reactor , Stepper{
    
    var disposeBag : DisposeBag = .init()
    
    var steps: PublishRelay<Step> = .init()
    
    enum Action{
        case managerBtnClick
        case managerDismiss
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

extension ManagerLoginModalReactor{
    func mutate(action: Action) -> Observable<Mutation> {
        switch action{
        case.managerDismiss:
            steps.accept(BambooStep.dismiss)
            return .empty()
        case .managerBtnClick:
            steps.accept(BambooStep.managerMainTabBarIsRequired)
            return.empty()
        }
    }
}
