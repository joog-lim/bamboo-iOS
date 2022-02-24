//
//  EmailWriteReactor.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2022/02/24.
//

import ReactorKit
import RxFlow
import RxSwift
import RxCocoa

final class EmailWriteReactor : Stepper, Reactor{
    var disposeBag : DisposeBag = .init()
    
    var steps: PublishRelay<Step> = .init()
    
    enum Action{
        case backbtnTap
        case sendEmail(String)
    }
    enum Mutation{
        case postEmailSuccess(email : String)
    }
    struct State{

    }
    let initialState: State
    let provider : ServiceProviderType
    let sub : String
    
    init(with provider : ServiceProviderType,sub : String){
        self.initialState = State()
        self.provider = provider
        self.sub = sub
    }
    
}
//MARK: - Mutation
extension EmailWriteReactor{
    func mutate(action: Action) -> Observable<Mutation> {
        switch action{
        case .backbtnTap:
            steps.accept(BambooStep.backBtnRequired)
            return .empty()
        case let .sendEmail(email):
            return postEmail(email: email)
        }
    }
}

//MARK: - Reduce
extension EmailWriteReactor{
    func reduce(state: State, mutation: Mutation) -> State {
        let new = state
        switch mutation{
        case let .postEmailSuccess(email):
            steps.accept(BambooStep.otpLoginIsRequired(sub: sub, email: email))
        }
        return new
    }
}

//MARK: - Method
private extension EmailWriteReactor{
    private func postEmail(email : String) -> Observable<Mutation>{
        let request = AuthenticationMailRequest(email: email)
        return self.provider.loginService.postAuthenticationMail(sub: sub, authenticationMailRequest: request)
            .map{Mutation.postEmailSuccess(email: email)}
    }
}
