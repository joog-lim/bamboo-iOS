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

}
