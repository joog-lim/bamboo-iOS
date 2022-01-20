import Foundation
import RxSwift

protocol ManagerServiceType{
    //get
    func getAdminAlgorithm(algorithmRequest : AdminAlgorithmRequest) -> Observable<Algorithm>
}

final class ManagerService : BaseService,ManagerServiceType{}

extension ManagerService{
    func getAdminAlgorithm(algorithmRequest: AdminAlgorithmRequest) -> Observable<Algorithm> {
        BamBooAPI.getAdminAlgorithm(algorithmRequest: algorithmRequest)
            .request()
            .map(Algorithm.self, using : BamBooAPI.jsonDecoder)
            .do(onError:{print($0)})
            .asObservable()
    }
}
