//
//  ServiceProvider.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/12/15.
//

protocol ServiceProviderType : class{
    var loginService : UserLoginServiceType {get}
}

final class ServiceProvider : ServiceProviderType{
    lazy var loginService: UserLoginServiceType = UserLoginService(provider: self)
}
