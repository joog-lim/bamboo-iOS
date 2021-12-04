//
//  GoogleOauthModalReactor.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/12/04.
//

import ReactorKit
import RxFlow
import RxCocoa

final class GoogleOauthModalReactor : Reactor , Stepper{
    
    
    var disposeBag : DisposeBag = .init()
    
    var steps: PublishRelay<Step> = .init()
    
    enum Action{
        
    }
    
    struct State{
        
    }
    let initialState: State
    
    init(){
        self.initialState = State()
    }
    
}
