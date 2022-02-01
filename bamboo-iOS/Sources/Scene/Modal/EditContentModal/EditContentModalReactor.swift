//
//  EditContentModalReactor.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/12/20.
//

import ReactorKit
import RxFlow
import RxCocoa

final class EditContentModalReactor : Reactor,Stepper{

    var disposeBag : DisposeBag = .init()

    var steps: PublishRelay<Step> = .init()
    
    enum Action{
        case editBtnTap(title : String, content : String)
        case cancelBtnTap
    }
    enum Mutation{
        case editSuccess
    }
    struct State{
        
    }
    //MARK: - Properties
    let initialState: State
    let provider : ServiceProviderType
    var idx : Int
    let indexPath : Int
    
    init(provider : ServiceProviderType, idx : Int, indexPath : Int){
        self.initialState = State()
        self.provider = provider
        self.idx = idx
        self.indexPath = indexPath
    }
}
//MARK: - Mutation
extension EditContentModalReactor{
    func mutate(action: Action) -> Observable<Mutation> {
        switch action{
        case let .editBtnTap(title, content):
            return patchEdit(title, content)
        case.cancelBtnTap:
            steps.accept(BambooStep.dismiss)
            return .empty()

        }
    }
}

//MARK: - Reduce
extension EditContentModalReactor{
    func reduce(state: State, mutation: Mutation) -> State {
        let new = state
        switch mutation{
        case .editSuccess:
            steps.accept(BambooStep.dismiss)
        }
        return new
    }
}

//MARK: - Method
extension EditContentModalReactor{
    private func patchEdit(_ title: String, _ content : String) -> Observable<Mutation>{
        let editRequest = EditAlgorithmRequest(title: title, content: content)
        return self.provider.managerService.patchEditAlgorithm(editRequest: editRequest, idx: idx)
            .map(Mutation.editSuccess)
    }
}
