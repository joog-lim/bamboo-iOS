//
//  UserService.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2022/01/12.
//

import Foundation
import RxSwift

protocol UserServiceType {
    //post
    
    //get
    func getAlgorithm(algorithmRequest : AlgorithmRequest) -> Observable<[Algorithm]>
    func getRule() -> Observable<Rule>
//    func verify() -> Observable<>
}
final class UserService : BaseService,UserServiceType{}

//MARK: - Post
extension UserService{
    func postAlgorithm(BulletinRequest : AlgorithmRequest){}
}


//MARK: - Get
/// - Algorithm
extension UserService {
    func getAlgorithm(algorithmRequest: AlgorithmRequest) -> Observable<[Algorithm]>{
        BamBooAPI.getAlgorithem(algorithmRequest: algorithmRequest)
            .request()
            .map([Algorithm].self, using : BamBooAPI.jsonDecoder)
            .do(onError:{print($0)})
            .asObservable()
    }
/// - Rule
    func getRule() -> Observable<Rule> {
        BamBooAPI.getRule
            .request()
            .map(Rule.self, using : BamBooAPI.jsonDecoder)
            .do(onError: {print($0)})
            .asObservable()
    }
}
