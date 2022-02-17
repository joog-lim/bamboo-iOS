//
//  AppleLoginReactor.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2022/02/17.
//

import ReactorKit
import RxFlow
import RxCocoa
import Network
import Moya
import KeychainSwift

final class AppleLoginReactor : Reactor , Stepper{
    
    var disposeBag : DisposeBag = .init()
    
    var steps: PublishRelay<Step> = .init()
    
    enum Action{
        case dismiss
        case appleLogin
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

//MARK: - Mutation
extension AppleLoginReactor{
    func mutate(action: Action) -> Observable<Mutation> {
        switch action{
        case .dismiss:
            steps.accept(BambooStep.dismiss)
            return .empty()
        case .appleLogin:
            UserDefaults.standard.set(true, forKey: "gest")
            steps.accept(BambooStep.dismiss)
            return .empty()
        }
    }
}
