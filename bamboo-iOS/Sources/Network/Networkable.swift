//
//  Networkable.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/12/09.
//

import Foundation
import Moya

protocol Networkable{
    /// provider객체 생성 시 Moya에서 제공하는 TargetType을 명시해야 하므로 타입 필요
    associatedtype Target : TargetType
    /// DIP를 위해 protocol에 provider객체를 만드는 함수 정의
    static func makeProvider() -> MoyaProvider<Target>
}
extension Networkable{
    static func makeProvider() -> MoyaProvider<Target>{
        return MoyaProvider<Target>()
    }
}
