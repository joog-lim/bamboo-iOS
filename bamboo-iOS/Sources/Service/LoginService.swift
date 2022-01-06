//
//  UserLoginService.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/12/15.
//

import Foundation
import RxSwift


protocol LoginServiceType : AnyObject{
    var didLoginObservable : Observable<Bool> {get}
}
final class LoginService : BaseService, LoginServiceType{
    
    let defaults = UserDefaults.standard

    var didLoginObservable: Observable<Bool>{
        return defaults.rx
            .observe(Bool.self,"LoginStatus")
            .map{ $0 ?? false}
    }
}
