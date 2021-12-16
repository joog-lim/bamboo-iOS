//
//  BaseService.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/12/15.
//

class BaseService{
    unowned let provider : ServiceProviderType
    
    init(provider : ServiceProviderType){
        self.provider = provider
    }
}
