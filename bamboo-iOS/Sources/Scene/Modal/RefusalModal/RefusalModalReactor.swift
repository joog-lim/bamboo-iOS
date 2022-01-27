//
//  RefusalModalReactor.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/12/19.
//

import ReactorKit
import RxFlow
import RxCocoa

final class RefusalModalReactor : Reactor,Stepper{

    var disposeBag : DisposeBag = .init()

    var steps: PublishRelay<Step> = .init()
    
    enum Action{
        case refusalBtnTap(reason: String)
    }
    enum Mutation{
        case refusalSuccess
    }
    struct State{
        
    }
    let initialState: State
    let provider : ServiceProviderType
    let idx : Int
    
    init(provider : ServiceProviderType, idx : Int,algorithmNumber : Int, index : Int){
        self.initialState = State()
        self.provider = provider
        self.idx = idx
    }
}
//MARK: - Mutation
extension RefusalModalReactor{
    func mutate(action: Action) -> Observable<Mutation> {
        switch action{
        case let .refusalBtnTap(reason):
            return patchRefusal(reason: reason)
        }
    }
}
//MARK: - Reduce
extension RefusalModalReactor{
    func reduce(state: State, mutation: Mutation) -> State {
        let new = state
        switch mutation{
        case .refusalSuccess:
            steps.accept(BambooStep.dismiss)
        }
        return new
    }
}

//MARK: - Method
extension RefusalModalReactor{
    private func patchRefusal(reason : String) -> Observable<Mutation>{
        let refusalRequest = EditStatusRequest(status: "REJECTED", reason: reason)
        return self.provider.managerService.patchRefusalAlgorithm(refusalRequest: refusalRequest, idx: idx)
            .map(Mutation.refusalSuccess)
    }
}
