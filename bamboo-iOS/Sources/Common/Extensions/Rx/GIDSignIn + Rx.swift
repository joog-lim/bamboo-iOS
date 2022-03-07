//
//  GIDSignIn + Rx.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2022/03/04.
//

import GoogleSignIn
import RxCocoa
import RxSwift
import UIKit


@available(iOS 13.0, *)
extension Reactive where Base: GIDSignIn{
    public func login(on vc : UIViewController) -> Observable<GIDGoogleUser>{
        let signConfig = GIDConfiguration.init(clientID: "469455837990-lkd2grmq4c947eierj7m6rh83259m2ro.apps.googleusercontent.com")
        
        GIDSignIn.sharedInstance.signIn(with: signConfig, presenting: vc) { user, error in
            guard error == nil else {return}
            guard let user = user else {return}
            
        }
        return 
    }
}

@available(iOS 13.0, *)
extension Reactive where Base: CustomGoogleOauthBtn{
    internal func loginonTap(on vc : UIViewController) -> Observable<GIDGoogleUser>{
        let window = vc
        return controlEvent(.touchUpInside)
            .flatMap{
                GIDSignIn.sharedInstance.rx.login(on: window)
            }
    }
    internal func login(on vc : UIViewController) -> Observable<GIDGoogleUser>{
        return GIDSignIn.sharedInstance.rx.login(on: vc)
    }
}
