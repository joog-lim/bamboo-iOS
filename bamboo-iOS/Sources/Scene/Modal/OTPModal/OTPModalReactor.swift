//
//  OTPModalReactor.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2022/02/22.
//

import ReactorKit
import RxFlow
import RxSwift
import RxCocoa

final class OTPModalReactor : Reactor, Stepper{
    
    var disposeBag : DisposeBag = .init()
    
    var steps: PublishRelay<Step> = .init()
    
    enum Action{
        case dismiss
    }
    enum Mutation{
        
    }
    struct State{
        
    }
    let initialState: State
    let provider : ServiceProviderType
    
    init(with provider : ServiceProviderType){
        self.initialState = State()
        self.provider = provider
    }
}
//MARK: - Mutate
extension OTPModalReactor{
    func mutate(action: Action) -> Observable<Mutation> {
        switch action{
        case .dismiss:
            steps.accept(BambooStep.dismiss)
            return .empty()
        }
    }
}
