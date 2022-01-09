//
//  AuthService.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2022/01/08.
//

import Foundation
import Moya
import RxSwift

final class AuthService{
    static let shared = AuthService()
    
    init(){}
    
    //MARK: - 토큰 재발급
//    func renewalToken(refreshToken : String) -> Single<Response>{
//        return BamBooAPI.renewalToken(refreshToken : refreshToken)
//            .request()
//            .map{
//                guard let value = try $0.mapString().data(using: .utf8) else {return $0}
//                let newResponse = Response(statusCode: $0.statusCode,data: value,request: $0.request,response: $0.response)
//                return newResponse}
//            .map{ Token.self, using: BamBooAPI.jsonDecoder}
//            .asObservable()
//    }
}

