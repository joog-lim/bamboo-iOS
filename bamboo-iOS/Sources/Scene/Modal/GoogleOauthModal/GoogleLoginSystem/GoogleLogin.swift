//
//  GoogleLogin.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/11/15.
//

import UIKit
import GoogleSignIn
import KeychainSwift
import RxSwift
import RxCocoa
import ReactorKit

final class GoogleLogin{
    static let shared = GoogleLogin()
    private let sign : GIDSignIn
    private let signInConfig = GIDConfiguration.init(clientID: "331482986393-l5d41ibbdkeafaaa5h12fs278rrjbp7t.apps.googleusercontent.com")
    
    private init(){
        sign = GIDSignIn.sharedInstance
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
                    
                    let idToken = authentication.idToken
                    KeychainSwift().set(idToken ?? "", forKey: "idToken")
                    UserDefaults.standard.set(true, forKey: "UserLogin")
//                    vc.rx.dismissed.map(Reactor.Action.googleModalDismiss)
//                        .source.bind(to: Reactor.Action)
//                        .disposed(by: DisposeBag)
                    // send id Token to backend
                }
                // 받을수 있는 값
//                let emailAddress = user.profile?.email
//                let fullName = user.profile?.name
//                let givenName = user.profile?.givenName
//                let profilePicUrl = user.profile?.imageURL(withDimension: 320)
            }
        }
    }
}
