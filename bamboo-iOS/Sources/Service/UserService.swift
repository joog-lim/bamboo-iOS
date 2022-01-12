//
//  UserService.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2022/01/12.
//

import Foundation
import RxSwift

protocol UserServiceType {
    func getAlgorithm(algorithmRequest : AlgorithmRequest) -> Observable<[Algorithm]>
    func getRule() -> Observable<[Rule]>
}
final class UserService : BaseService,UserServiceType{}

extension UserService {
    func getAlgorithm(algorithmRequest: AlgorithmRequest) -> Observable<[Algorithm]>{
        BamBooAPI.getAlgorithem(algorithmRequest: algorithmRequest)
            .request()
            .map([Algorithm].self, using : BamBooAPI.jsonDecoder)
            .do(onError:{print($0)})
            .asObservable()
    }
}

extension UserService {
    func getRule() -> Observable<[Rule]> {
        BamBooAPI.getRule
            .request()
            .map([Rule].self, using : BamBooAPI.jsonDecoder)
            .do(onError: {print($0)})
            .asObservable()
    }
}
