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
    case postRenewalToken
    //Login
    case postLogin(idToken : String)
    case postAppleLogin(idToken : String, appleLoginRequest : AppleLoginRequest)
    case postAuthenticationMail(sub : String, authenticationMailRequest : AuthenticationMailRequest)
    case postAuthenticationNumber(sub : String , authenticationNumberRequest : AuthenticationNumberRequest)
    //User
    case getAlgorithm(algorithmRequest : AlgorithmRequest)
    case getRule
    case getVerify
    case postEmoji(emojiRequest : EmojiRequest)
    case deleteEmoji(emojiRequest : EmojiRequest)
    
    case postBulletin(bulletinRequest : BulletinRequest)
    case patchStatus(statusRequest : EditStatusRequest, idx : Int)
    //Manager
    case getAdminAlgorithm(algorithmRequest : AdminAlgorithmRequest)
    case patchEditAlgorithm(editRequest : EditAlgorithmRequest, idx : Int)
    case deleteAlgorithm(idx : Int)
    
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
