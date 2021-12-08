//
//  WritingBulletinBoardReactor.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/12/07.
//

import ReactorKit
import RxFlow
import RxCocoa


final class WritingBulletinBoardReactor: Reactor , Stepper{
    
    var disposeBag : DisposeBag = .init()
    
    var steps: PublishRelay<Step> = .init()
    
    enum Action{
        case dismissModal
    }
    enum Mutation{
        
    }
    struct State{
        
    }
    
    let initialState: State
    
    init(){
        self.initialState = State()
    }
    deinit{
        print("\(type(of: self)): \(#function)")
    }
}

extension WritingBulletinBoardReactor{
    func mutate(action: Action) -> Observable<Mutation> {
        switch action{
        case.dismissModal:
            steps.accept(BambooStep.dismiss)
            return .empty()
        }
    }
}
