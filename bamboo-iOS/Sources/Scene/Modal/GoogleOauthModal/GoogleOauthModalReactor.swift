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
        case googleOauthLogin
        case googleModalDismiss
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

//MARK: - Mutation
extension GoogleOauthModalReactor{
    func mutate(action: Action) -> Observable<Action> {
        switch action{
        case.googleOauthLogin:
            print("google Oauth Login")
            return .empty()
        case.googleModalDismiss:
            steps.accept(BambooStep.dismiss)
            return .empty()
        }
    }
}
