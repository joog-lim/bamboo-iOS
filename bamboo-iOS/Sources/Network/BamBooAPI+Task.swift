//
//  BamBooAPI+Task.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2022/01/03.
//

import Moya

extension BamBooAPI{
    func getTask() -> Task{
        switch self{
        case .getAlgorithm(let algorithmRequest):
            return .requestParameters(parameters: algorithmRequest.toDictionary(), encoding: URLEncoding.queryString)
        case let .getAdminAlgorithm(algorithmRequest):
            return .requestParameters(parameters: algorithmRequest.toDictionary(), encoding: URLEncoding.queryString)
        case let .postBulletin(bulletinRequest):
            print(bulletinRequest)
            return .requestParameters(parameters: bulletinRequest.toDictionary(), encoding:URLEncoding.httpBody )
        default:
            return .requestPlain
        }
    }
}
