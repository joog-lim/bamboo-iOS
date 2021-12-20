//
//  EditContentModalReactor.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/12/20.
//

import ReactorKit
import RxFlow
import RxCocoa

final class EditContentModalReactor : Reactor,Stepper{

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

