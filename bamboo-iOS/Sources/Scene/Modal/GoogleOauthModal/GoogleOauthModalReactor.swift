//
//  GoogleOauthModalReactor.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/12/04.
//

import ReactorKit
import RxFlow
import RxCocoa
import Network
import Moya
import KeychainSwift

final class GoogleOauthModalReactor : Reactor , Stepper{
    
    var disposeBag : DisposeBag = .init()
    
    var steps: PublishRelay<Step> = .init()
    
    enum Action{
        case googleLoginBERequied(idToken: String)
        case googleModalDismiss
    }
    enum Mutation{
        case setLogin(accessToken : String , refreshToken : String)
    }
    struct State{
        var access :String = .init()
        var refresh : String = .init()
    }
    let initialState: State
    let provider : ServiceProviderType
    
    init(with provider : ServiceProviderType){
        self.initialState = State()
        self.provider = provider
    }
}

//MARK: - Mutation
extension GoogleOauthModalReactor{
    func mutate(action: Action) -> Observable<Mutation> {
        switch action{
        case.googleModalDismiss:
            steps.accept(BambooStep.dismiss)
            return .empty()
        case let .googleLoginBERequied(idToken):
            return postLogin(idToken)
        }
    }
}
//MARK: - Reduce
extension GoogleOauthModalReactor{
    func reduce(state: State, mutation: Mutation) -> State {
        var new = state
        switch mutation{
        case let .setLogin(accessToken, refreshToken):
            new.access = accessToken
            new.refresh = refreshToken
        }
        return new
    }
}

//MARK: - Method
private extension GoogleOauthModalReactor{
    func postLogin(_ idToken : String) -> Observable<Mutation>{
        return self.provider.loginService.postLogin(idToken: idToken)
            .map{Mutation.setLogin(accessToken: $0.access, refreshToken: $0.refresh)}
    }
}
