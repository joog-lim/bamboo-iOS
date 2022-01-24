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
        case let .postBulletin(bulletinRequest):
            return .requestJSONEncodable(bulletinRequest)
        case let .postLogin(idToken) :
            return .requestParameters(parameters: ["Authorization": idToken], encoding: URLEncoding.default)
            //patch
        case let .patchReport(reportRequest,_):
            return .requestJSONEncodable(reportRequest)

        default:
            return .requestPlain
        }
    }
}
