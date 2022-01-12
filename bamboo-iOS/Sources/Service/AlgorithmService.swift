//
//  AlgorithmService.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2022/01/10.
//

import Foundation
import RxSwift

protocol AlgorithmServiceType {
    func getAlgorithm(algorithmRequest : AlgorithmRequest) -> Observable<[Algorithm]>
}
final class AlgorithmService : BaseService,AlgorithmServiceType{
    func getAlgorithm(algorithmRequest: AlgorithmRequest) -> Observable<[Algorithm]>{
        BamBooAPI.getAlgorithem(algorithmRequest: algorithmRequest)
            .request()
            .map([Algorithm].self, using : BamBooAPI.jsonDecoder)
            .do(onError:{print($0)})
            .asObservable()
    }
}
