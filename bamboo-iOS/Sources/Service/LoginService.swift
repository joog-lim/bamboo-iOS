//
//  UserLoginService.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/12/15.
//

import Foundation
import RxSwift

protocol LoginServiceType {
    var didLoginObservable : Observable<Bool> {get}
    func postLogin(idToken : String) -> Observable<Login>
}
final class LoginService : BaseService, LoginServiceType{
    //MARK: - Login 됬는지 안됬는지 여부 판단
    let defaults = UserDefaults.standard

    var didLoginObservable: Observable<Bool>{
        return defaults.rx
            .observe(Bool.self,"LoginStatus")
            .map{ $0 ?? false}
    }
}

//MARK: - Post
extension LoginService {
    //Login
    func postLogin(idToken : String) -> Observable<Login>{
        BamBooAPI.postLogin(idToken: idToken)
            .request()
            .map(Login.self,using: BamBooAPI.jsonDecoder)
            .do(onError: {print($0)})
            .asObservable()
    }
    //RefreshToken
}
