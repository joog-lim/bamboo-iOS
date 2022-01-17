protocol ServiceProviderType : AnyObject{
    var loginService : LoginServiceType {get}
    var userService : UserServiceType {get}
    var managerService : ManagerServiceType{get}
}

final class ServiceProvider : ServiceProviderType{
    lazy var loginService: LoginServiceType = LoginService(provider: self)
    lazy var userService: UserServiceType = UserService(provider: self)
    lazy var managerService: ManagerServiceType = ManagerService(provider: self)
}
