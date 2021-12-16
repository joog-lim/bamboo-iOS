//
//  UserLoginService.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/12/15.
//

import Foundation
import RxSwift


protocol UserLoginServiceType : class{
    var didLoginObservable : Observable<Bool> {get}
    var didLogin: Bool {get}
}
final class UserLoginService : BaseService, UserLoginServiceType{
    let defaults = UserDefaults.standard
    
    var didLogin: Bool{
        return defaults.bool(forKey: "UserLogin")
    }
    var didLoginObservable: Observable<Bool>{
        return .just(didLogin)
    }
}

extension UserLoginService : ReactiveCompatible{}

extension Reactive where Base : UserLoginService{
    var didLogin : Observable<Bool>{
        return UserDefaults.standard.rx
            .observe(Bool.self, "UserLogin" )
            .map{ $0 ?? false}
    }
}
