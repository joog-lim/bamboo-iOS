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
            //get
        case .getAlgorithm(let algorithmRequest):
            return .requestParameters(parameters: algorithmRequest.toDictionary(), encoding: URLEncoding.queryString)
        case let .getAdminAlgorithm(algorithmRequest):
            return .requestParameters(parameters: algorithmRequest.toDictionary(), encoding: URLEncoding.queryString)
            //post
        case let .postLogin(loginRequest):
            return .requestJSONEncodable(loginRequest)
        case let .postBulletin(bulletinRequest):
            return .requestJSONEncodable(bulletinRequest)
            //patch
        case let .patchReport(reportRequest,_):
            return .requestJSONEncodable(reportRequest)
        case let .patchEditAlgorithm(editRequest,_):
            return .requestJSONEncodable(editRequest)
        default:
            return .requestPlain
        }
    }
}
