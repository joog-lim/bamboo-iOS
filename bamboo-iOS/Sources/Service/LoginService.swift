import Foundation
import RxSwift
import Moya

protocol LoginServiceType {
    var didLoginObservable : Observable<Bool> {get}
    var isAdminObservable : Observable<Bool> {get}

    func postLogin(idToken : String) -> Observable<Login>
    func postRefresh() -> Single<Response>
    func postAppleLogin(idToken : String, appleLoginRequest: AppleLoginRequest) -> Observable<AppleLogin>
    func postAuthenticationMail(sub : String, authenticationMailRequest : AuthenticationMailRequest) -> Observable<Base>
    func postAuthenticationNumber(sub: String, authenticationNumberRequest : AuthenticationNumberRequest) -> Observable<AppleLogin>
}
final class LoginService : BaseService, LoginServiceType{
    
    //MARK: - Login 됬는지 안됬는지 여부 판단
    let defaults = UserDefaults.standard

    var didLoginObservable: Observable<Bool>{
        return defaults.rx
            .observe(Bool.self,"LoginStatus")
            .map{ $0 ?? false}
    }
    var isAdminObservable: Observable<Bool>{
        return defaults.rx
            .observe(Bool.self,"isAdmin")
            .map{ $0 ?? false}
    }

}

//MARK: - Post
extension LoginService {
    //Login
    func postLogin(idToken : String) -> Observable<Login> {
        BamBooAPI.postLogin(idToken: idToken)
            .request()
            .map(Login.self, using : BamBooAPI.jsonDecoder)
            .do(onError:{print($0)})
            .asObservable()
    }
    
    //RefreshToken
    func postRefresh() -> Single<Response>{
        BamBooAPI.postRenewalToken
            .request()
    }
    
    func postAppleLogin(idToken: String, appleLoginRequest: AppleLoginRequest) -> Observable<AppleLogin> {
        BamBooAPI.postAppleLogin(idToken: idToken, appleLoginRequest: appleLoginRequest)
            .request()
            .map(AppleLogin.self,using: BamBooAPI.jsonDecoder)
            .do(onError: {print($0)})
            .asObservable()
    }
    
    func postAuthenticationMail(sub : String, authenticationMailRequest : AuthenticationMailRequest) -> Observable<Base>{
        BamBooAPI.postAuthenticationMail(sub: sub, authenticationMailRequest: authenticationMailRequest)
            .request()
            .map(Base.self, using: BamBooAPI.jsonDecoder)
            .do(onError : {print($0)})
            .asObservable()
    }
    
    func postAuthenticationNumber(sub: String, authenticationNumberRequest: AuthenticationNumberRequest) -> Observable<AppleLogin> {
        BamBooAPI.postAuthenticationNumber(sub: sub, authenticationNumberRequest: authenticationNumberRequest)
            .request()
            .map(AppleLogin.self,using: BamBooAPI.jsonDecoder)
            .do(onError : {print($0)})
            .asObservable()
    }
}

