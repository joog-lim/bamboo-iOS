//
//  ServiceProvider.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/12/15.
//

protocol ServiceProviderType : AnyObject{
    var loginService : LoginServiceType {get}
    var userService : UserServiceType {get}
}

final class ServiceProvider : ServiceProviderType{
    lazy var loginService: LoginServiceType = LoginService(provider: self)
    lazy var userService: UserServiceType = UserService(provider: self)

}
