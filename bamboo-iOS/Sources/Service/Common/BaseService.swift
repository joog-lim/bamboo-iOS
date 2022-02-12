class BaseService  {
    unowned let provider : ServiceProviderType
    
    init(provider : ServiceProviderType){
        self.provider = provider
    }
}
