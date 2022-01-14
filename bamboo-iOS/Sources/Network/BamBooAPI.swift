//
//  BamBooAPI.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2022/01/03.
//

import Moya
import Alamofire

enum BamBooAPI {
    //System
    case postRenewalToken(refreshToken : String)
    //Login
    case postLogin(idToken  : String)
    
    //User
    case getAlgorithem(algorithmRequest : AlgorithmRequest)
    case getRule
    case getVerify
    
    case postBulletin(bulletinRequest : BulletinRequest)
}

extension BamBooAPI : Moya.TargetType{
    var baseURL: URL { self.getBaseURL()}
    var path: String { self.getPath()}
    var method: Moya.Method { self.getMethod() }
    var sampleData: Data {Data()}
    var task: Task { self.getTask()}
    var headers: [String : String]? {self.getHeader()}
    var validationType: ValidationType{ return .successCodes}
}
