//
//  AuthenticationServices+Rx.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2022/02/17.
//

import AuthenticationServices
import RxCocoa
import RxSwift
import UIKit

@available(iOS 13.0, *)
extension Reactive where Base: ASAuthorizationAppleIDProvider{
    public func login(scope: [ASAuthorization.Scope]? = nil, on window : UIWindow) -> Observable<ASAuthorization>{
        let request = base.createRequest()
        request.requestedScopes = scope
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
        
        let proxy = ASAuthorizationControllerProxy.proxy(for: controller)
        proxy.presentationWindow = window
        
        controller.presentationContextProvider = proxy
        controller.performRequests()
        
        return proxy.didComplete
    }
}

@available(iOS 13.0, *)
extension Reactive where Base: ASAuthorizationAppleIDButton {
    public func loginOnTap(scope: [ASAuthorization.Scope]? = nil) -> Observable<ASAuthorization> {
        let window = base.window!
        return controlEvent(.touchUpInside)
            .flatMap {
                ASAuthorizationAppleIDProvider().rx.login(scope: scope, on: window)
            }
    }

    public func login(scope: [ASAuthorization.Scope]? = nil) -> Observable<ASAuthorization> {
        return ASAuthorizationAppleIDProvider().rx.login(scope: scope, on: base.window!)
    }
}
