//
//  APIEnvironment.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/12/09.
//

import Foundation
import Moya
import RxAppState

//각 base url 정의
enum APIEnvironment : String {
    case bamboo = "https://server.joog-lim.info/apiV2"
}
struct NetworkManager{

    static let environment : APIEnvironment = .bamboo
}
