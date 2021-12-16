//
//  NetworkManager.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/12/02.
//

import RxSwift
import Moya

protocol NetworkManagerType : class{

}
final class NetworkManager: NetworkManagerType{
    static let shared = NetworkManager()
    
    
}
