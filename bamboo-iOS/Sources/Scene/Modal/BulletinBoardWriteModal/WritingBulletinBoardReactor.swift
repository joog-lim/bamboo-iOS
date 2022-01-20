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
        case sendBtnTap(_ title : String? , _ content : String? ,_ tag : String? ,_ id : String?,_ answer : String?)
    }
    enum Mutation{
        case setQuestion(_ id : String , _ question : String)
        case postSuccess
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
        case let .sendBtnTap(title,content,tag,id,answer):
            return postBulletin(title: title ?? "", content: content ?? "", tag: tag ?? "", answer: answer ?? "")
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
        case .postSuccess:
            steps.accept(BambooStep.dismiss)
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

//MARK: - Post Bulletin
extension WritingBulletinBoardReactor{
    private func postBulletin(title : String, content : String, tag: String, answer : String) -> Observable<Mutation>{
        let bulletRequest = BulletinRequest(title: title, content: content, tag: tag, verify: .init(id: "", answer: answer))
//        return  self.provider.userService.postBulletin(bulletinRequest: bulletRequest)
//            .map{Mutation.postSuccess}
        return .empty()
    }
}
