//
//  GoogleLogin.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/11/15.
//

import UIKit
import GoogleSignIn
import KeychainSwift
import ReactorKit

final class GoogleLogin{
    static let shared = GoogleLogin(with: ServiceProvider())
    let reactor : OauthReactor
    
    private let sign : GIDSignIn
    private let signInConfig = GIDConfiguration.init(clientID:   "469455837990-lkd2grmq4c947eierj7m6rh83259m2ro.apps.googleusercontent.com")
    private let disposeBag : DisposeBag = .init()
    private let provider : ServiceProviderType
    private init(with provider : ServiceProviderType){
        sign = GIDSignIn.sharedInstance
        self.provider = provider
        self.reactor = .init(with: self.provider)
    }
    public func SignOutOauth(){
        sign.signOut()
        GIDSignIn.sharedInstance.disconnect { error in
            guard error == nil else {return}
            // Google Account disconnected from your app.
            // Perform clean-up actions, such as deleting data associated with the
            //   disconnected account.
        }
    }
    public func SignInOauth(vc : UIViewController){
        DispatchQueue.main.async { [self] in
            sign.signIn(with: signInConfig, presenting: vc) { user, error in
                guard error  == nil else {return}
                guard let user = user else {return }

                user.authentication.do { authentication, error in
                    guard error == nil else {return }
                    guard let authentication = authentication else {return}
                    reactor.action.onNext(.googleLoginBERequied(idToken: authentication.idToken!))
                    // send id Token to backend
                }
            }
        }
    }
}

