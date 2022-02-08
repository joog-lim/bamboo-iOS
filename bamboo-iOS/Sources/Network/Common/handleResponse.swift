//
//  handleResponse.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2022/02/09.
//

import Foundation
import Moya
import RxSwift
import KeychainSwift

/// 서버에서 보내주는 오류 문구 파싱용
extension PrimitiveSequence where Trait == SingleTrait, Element == Response {
    func handleResponse() -> Single<Element> {
        return flatMap{ response in
            if let newToken = try? response.map(Token.self){
                UserDefaults.standard.set(newToken.data.isAdmin, forKey: "isAdmin")
                KeychainSwift().set(newToken.data.access, forKey: "accessToken")
            }
            if (200...299) ~= response.statusCode{
                return Single.just(response)
            }
            
            if var error = try? response.map(ResponseError.self){
                error.statusCode = response.statusCode
                return Single.error(error)
            }
            let genericError = ResponseError(statusCode: response.statusCode, message: "empty message", documentation_url: "")
            return Single.error(genericError)
        }
    }
}

struct ResponseError: Decodable, Error {
  var statusCode: Int?
  let message: String
  let documentation_url: String
}
