import Foundation
import RxSwift

protocol ManagerServiceType{
    //get
    func getAdminAlgorithm(algorithmRequest : AdminAlgorithmRequest) -> Observable<Algorithm>
    //patch
    func patchEditAlgorithm(editRequest : EditAlgorithmRequest,idx : Int) -> Observable<Base>
}

final class ManagerService : BaseService,ManagerServiceType{}

//MARK: - Get
extension ManagerService{
    func getAdminAlgorithm(algorithmRequest: AdminAlgorithmRequest) -> Observable<Algorithm> {
        BamBooAPI.getAdminAlgorithm(algorithmRequest: algorithmRequest)
            .request()
            .map(Algorithm.self, using : BamBooAPI.jsonDecoder)
            .do(onError:{print($0)})
            .asObservable()
    }
}

//MARK: - Patch
extension ManagerService{
    func patchEditAlgorithm(editRequest: EditAlgorithmRequest, idx: Int) -> Observable<Base> {
        BamBooAPI.patchEditAlgorithm(editRequest: editRequest, idx: idx)
            .request()
            .map(Base.self)
            .do(onError : {print($0)})
            .asObservable()
    }
}
