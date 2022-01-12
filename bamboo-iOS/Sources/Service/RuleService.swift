//
//  RuleService.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2022/01/12.
//

import Foundation
import RxSwift

protocol RuleServiceType {
    func getRule() -> Observable<[Rule]>
}
final class RuleService : BaseService , RuleServiceType{
    func getRule() -> Observable<[Rule]> {
        BamBooAPI.getRule
            .request()
            .map([Rule].self, using : BamBooAPI.jsonDecoder)
            .do(onError: {print($0)})
            .asObservable()
    }
}
