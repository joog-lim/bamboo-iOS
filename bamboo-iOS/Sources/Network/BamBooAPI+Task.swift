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
        case let .postEmoji(emojiRequest):
            return .requestJSONEncodable(emojiRequest)
        case let .postAppleLogin(_ , appleLoginRequest):
            return .requestJSONEncodable(appleLoginRequest)
        case let .postAuthenticationMail(_ , authenticationMailRequest):
            return .requestJSONEncodable(authenticationMailRequest)
        case let .postAuthenticationNumber(_, authenticationNumberRequest):
            return .requestJSONEncodable(authenticationNumberRequest)
            //patch
        case let .patchStatus(statusRequest,_):
            return .requestJSONEncodable(statusRequest)
        case let .patchEditAlgorithm(editRequest,_):
            return .requestJSONEncodable(editRequest)
            //delete
        case let .deleteEmoji(emojiRequest):
            return .requestJSONEncodable(emojiRequest)
        default:
            return .requestPlain
        }
    }
}
