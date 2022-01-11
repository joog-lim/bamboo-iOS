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
        case .getAlgorithem(let request):
            return .requestParameters(parameters: request.toDictionary(), encoding: URLEncoding.queryString)
        default:
            return .requestPlain
        }
    }
}
