//
//  WritingBulletinBoardReactor.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/12/07.
//

import ReactorKit
import RxFlow
import RxCocoa

final class WritingBulletinBoardReactor: Reactor , Stepper{
    
    var disposeBag : DisposeBag = .init()
    
    var steps: PublishRelay<Step> = .init()
    
    enum Action{
        case viewWillAppear
        case dismissModal
    }
    enum Mutation{
        case setQuestion(_ id : String , _ question : String)
    }
    struct State{
        var id , question : String?
    }
    
    //MARK: - Properties
    let provider : ServiceProviderType
    let initialState: State

    init(with provider : ServiceProviderType){
        self.initialState = State()
        self.provider = provider
    }
}

//MARK: - Mutation
extension WritingBulletinBoardReactor{
    func mutate(action: Action) -> Observable<Mutation> {
        switch action{
        case .viewWillAppear:
            return getVerify()
        case.dismissModal:
            steps.accept(BambooStep.dismiss)
            return .empty()
        }
    }
}

//MARK: - reduce
extension WritingBulletinBoardReactor{
    func reduce(state: State, mutation: Mutation) -> State {
        var new = state
        switch mutation{
        case let .setQuestion(id, question):
            new.id = id
            new.question = question
        }
        return new
    }
}

//MARK: - Get Qeustion
extension WritingBulletinBoardReactor{
    private func getVerify() -> Observable<Mutation>{
        return self.provider.userService.getVerify()
            .map{Mutation.setQuestion($0.id, $0.question)}
    }
}
