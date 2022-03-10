protocol ServiceProviderType : AnyObject{
    var userService : UserServiceType {get}
}

final class ServiceProvider : ServiceProviderType{
    lazy var userService: UserServiceType = UserService(provider: self)
}
