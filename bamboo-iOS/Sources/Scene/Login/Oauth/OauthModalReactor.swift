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
import AuthenticationServices

final class OauthReactor : Reactor , Stepper{
    
    var disposeBag : DisposeBag = .init()
    
    var steps: PublishRelay<Step> = .init()
    
    enum Action{
        case googleLoginBERequied(idToken: String)
        case backBtnRequired
        case appleLoginBERequest(result: ASAuthorizationAppleIDCredential)
    }
    enum Mutation{
        case setLogin(accessToken : String , refreshToken : String, isAdmin : Bool)
        case setAppleLogin(isAuth : Bool , sub : String? ,accessToken : String?, refreshToken : String?, isAdmin : Bool?)
    }
    struct State{
        var access :String = .init()
        var refresh : String = .init()
        var isAdmin : Bool = .init()
    }
    let initialState: State
    let provider : ServiceProviderType
    
    init(with provider : ServiceProviderType){
        self.initialState = State()
        self.provider = provider
    }
}

//MARK: - Mutation
extension OauthReactor{
    func mutate(action: Action) -> Observable<Mutation> {
        switch action{
            
        case.backBtnRequired:
            steps.accept(BambooStep.backBtnRequired)
            return .empty()
        case let .googleLoginBERequied(idToken):
            return postLogin(idToken)
        case let .appleLoginBERequest(result):
            return postAppleLogin(result: result)
        }
    }
}
//MARK: - Reduce
extension OauthReactor{
    func reduce(state: State, mutation: Mutation) -> State {
        let new = state
        switch mutation{
        case let .setLogin(accessToken, refreshToken,isAdmin):
            KeychainSwift().set(accessToken, forKey: "accessToken")
            KeychainSwift().set(refreshToken, forKey: "refreshToken")
            UserDefaults.standard.set(isAdmin, forKey: "isAdmin")
            UserDefaults.standard.set(true, forKey: "LoginStatus")
            print("backBtnRequied")
            steps.accept(BambooStep.backBtnRequired)
        case let .setAppleLogin(isAuth, sub, accessToken, refreshToken, isAdmin):
            if isAuth{
                KeychainSwift().set(accessToken ?? "", forKey: "accessToken")
                KeychainSwift().set(refreshToken ?? "", forKey: "refreshToken")
                UserDefaults.standard.set(isAdmin, forKey: "isAdmin")
                UserDefaults.standard.set(true, forKey: "LoginStatus")
                steps.accept(BambooStep.LoginIsRequired)
            }else{
                steps.accept(BambooStep.enterEmailIsRequired(sub: sub ?? ""))
            }
        }
        return new
    }
}

//MARK: - Method
private extension OauthReactor{
    private func postLogin(_ idToken : String) -> Observable<Mutation>{
        return self.provider.loginService.postLogin(idToken: idToken)
            .map{ Mutation.setLogin(accessToken: $0.data.access, refreshToken: $0.data.refresh,isAdmin: $0.data.admin)}
    }
    private func postAppleLogin(result : ASAuthorizationAppleIDCredential) -> Observable<Mutation>{
        let appleLoginRequest = AppleLoginRequest(name: UserDefaults.standard.string(forKey: "name")!)
        return self.provider.loginService.postAppleLogin(idToken: (String(data: result.identityToken!, encoding: .utf8) ?? ""), appleLoginRequest: appleLoginRequest)
            .map{ Mutation.setAppleLogin(isAuth: $0.data.isAuth ?? Bool(), sub: $0.data.sub, accessToken: $0.data.access, refreshToken: $0.data.refresh, isAdmin: $0.data.isAdmin)}
    }
}
