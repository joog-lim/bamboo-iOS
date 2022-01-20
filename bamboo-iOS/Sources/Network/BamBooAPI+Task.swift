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
        case let .getAlgorithm(algorithmRequest):
            return .requestParameters(parameters: algorithmRequest.toDictionary(), encoding: URLEncoding.queryString)
        case let .getAdminAlgorithm(algorithmRequest):
            return .requestParameters(parameters: algorithmRequest.toDictionary(), encoding: URLEncoding.queryString)
        default:
            return .requestPlain
        }
    }
}
