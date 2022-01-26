import Foundation
import RxSwift

protocol LoginServiceType {
    var didLoginObservable : Observable<Bool> {get}
    func postLogin(loginRequest : LoginRequest) -> Observable<Login>
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
    func postLogin(loginRequest : LoginRequest) -> Observable<Login> {
        BamBooAPI.postLogin(loginRequest: loginRequest)
            .request()
            .map(Login.self, using : BamBooAPI.jsonDecoder)
            .do(onError:{print($0)})
            .asObservable()
    }
    
    //RefreshToken
}

