import Foundation
import RxSwift
import Moya

protocol LoginServiceType {
    var didLoginObservable : Observable<Bool> {get}
    var isAdminObservable : Observable<Bool> {get}
    var gestLoginObservable: Observable<Bool> {get}

    func postLogin(idToken : String) -> Observable<Login>
    func postRefresh() -> Single<Response>
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
    var gestLoginObservable: Observable<Bool>{
        return defaults.rx
            .observe(Bool.self,"gest")
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
}

