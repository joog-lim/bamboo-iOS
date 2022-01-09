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
    
    init(){
        self.initialState = State()
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
            return fetchLogin(idToken)
        }
    }
}
//MARK: - Reduce
extension GoogleOauthModalReactor{
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation{
        case let .setLogin(accessToken, refreshToken):
            print("access : \(accessToken) , refresh : \(refreshToken)")
            newState.access = accessToken
            newState.refresh = refreshToken
        }
        return newState
    }
}

//MARK: - Method
private extension GoogleOauthModalReactor{
    func fetchLogin(_ idToken : String) -> Observable<Mutation>{
        return BamBooAPI.postLogin(idToken: idToken)
            .request()
            .map{
                guard let value = try $0.mapString().data(using: .utf8) else {return $0}
                let newResponse = Response(statusCode: $0.statusCode,data: value,request: $0.request,response: $0.response)
                return newResponse
            }
            .map(Login.self,using: BamBooAPI.jsonDecoder)
            .asObservable()
            .map{Mutation.setLogin(accessToken: $0.access, refreshToken: $0.refresh)}
    }
}
