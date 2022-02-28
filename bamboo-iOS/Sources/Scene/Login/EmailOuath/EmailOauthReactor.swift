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
import KeychainSwift
import AuthenticationServices

final class EmailOauthReactor : Reactor, Stepper{
    
    var disposeBag : DisposeBag = .init()
    
    var steps: PublishRelay<Step> = .init()
    
    private  let isRunningFirst: BehaviorRelay = BehaviorRelay(value: false)

    enum Action{
        case backBtnRequired
        case refreshOTPBtnRequired
        case sendOTPBtnRequired(String)
    }
    enum Mutation{
        case refreshAuthenticationMail
        case sendAuthenticationNumber(access :  String, refresh : String, isAdmin : Bool)
    }
    struct State{
        var time : Int?
    }
    let initialState: State
    let provider : ServiceProviderType
    let sub, email : String
    
    init(with provider : ServiceProviderType, sub : String,email : String){
        self.initialState = State()
        self.provider = provider
        self.sub = sub
        self.email = email
    }
}
//MARK: - Mutate
extension EmailOauthReactor{
    func mutate(action: Action) -> Observable<Mutation> {
        switch action{

        case .backBtnRequired:
            steps.accept(BambooStep.backBtnRequired)
            return .empty()
        case .refreshOTPBtnRequired:
            return postOTPauthenticationMail(sub: sub, email: email)
        case let .sendOTPBtnRequired(number):
            return postSendOTPNumber(sub: sub, number: number)
        }
    }
}
//MARK: - Reduce
extension EmailOauthReactor{
    func reduce(state: State, mutation: Mutation) -> State {
        var new = state
        switch mutation{
        case .refreshAuthenticationMail:
            new.time = 0
        case let .sendAuthenticationNumber(access, refresh, isAdmin):
            KeychainSwift().set(access , forKey: "accessToken")
            KeychainSwift().set(refresh , forKey: "refreshToken")
            UserDefaults.standard.set(isAdmin, forKey: "isAdmin")
            UserDefaults.standard.set(true, forKey: "LoginStatus")
            steps.accept(BambooStep.LoginIsRequired)
        }
        return new
    }
}

//MARK: - Post
private extension EmailOauthReactor{
    private func postOTPauthenticationMail(sub : String, email : String) -> Observable<Mutation>{
        let request = AuthenticationMailRequest(email: email)
        return self.provider.loginService.postAuthenticationMail(sub: sub, authenticationMailRequest: request)
            .map{ Mutation.refreshAuthenticationMail}
    }
    private func postSendOTPNumber(sub : String, number : String) -> Observable<Mutation>{
        let request = AuthenticationNumberRequest(authenticationNumber: number)
        return self.provider.loginService.postAuthenticationNumber(sub: sub, authenticationNumberRequest: request)
            .map{ Mutation.sendAuthenticationNumber(access: $0.data.access ?? "", refresh: $0.data.refresh ?? "", isAdmin: $0.data.isAdmin ?? Bool())}
    }
}
