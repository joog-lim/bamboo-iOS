//
//  noWifiReactor.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/12/22.
//

import ReactorKit
import RxCocoa
import RxFlow

final class noWifiReactor : Reactor, Stepper{
    
    //MARK: - Properties
    var disposeBag : DisposeBag = .init()
    
    //MARK: - Stepper
    var steps: PublishRelay<Step> = .init()
    //MARK: - represent user action(유저 액션을 나타냄)
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
//MARK: - Extension

extension noWifiReactor{

}

