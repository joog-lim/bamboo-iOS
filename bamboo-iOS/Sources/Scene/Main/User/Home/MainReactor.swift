//
//  MainReactor.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/12/06.
//
import UIKit

import ReactorKit
import RxFlow
import RxRelay

final class MainReactor : Reactor, Stepper{
    //MARK: - Stepper
    var steps: PublishRelay<Step> = .init()

    //MARK: - Event
    enum Action{
        case viewDidLoad
        case writeData
        case emojiBtnClick(idx : Int,indexPath : Int,state : Bool)
        case reportBtnClickAction(idx : Int, index : Int)
        case pagination(
            contentHeight: CGFloat,
            contentOffsetY: CGFloat,
            scrollViewHeight: CGFloat
        )
        case refreshDataLoad
    }
    enum Mutation{
        case updateDataSource([MainSection.Item])
        case postEmoji(indexPath : Int)
        case deleteEmoji(indexPath : Int)
    }
    struct State{
        var mainSection = MainSection.Model(
            model: 0,
            items: []
         )
    }
    
    //MARK: - Properties
    let provider : ServiceProviderType
    var currentPage = 0
    let initialState : State
        
    init(provider : ServiceProviderType){
        self.initialState = State()
        self.provider = provider
    }
}

//MARK: - Mutation
extension MainReactor{
    func mutate(action: Action) -> Observable<Mutation> {
        switch action{
        case .viewDidLoad:
            return getAlgorithm()
        case .writeData:
            steps.accept(BambooStep.writeModalIsRequired)
            return .empty()
        case let .reportBtnClickAction( idx,index):
            steps.accept(BambooStep.reportModalsRequired(idx: idx, index: index))
            return .empty()
        case let .pagination(contentHeight , contentOffsetY, scrollViewHeight):
            let paddingSpace = contentHeight - contentOffsetY
            if paddingSpace < scrollViewHeight{
                return getAlgorithm()
            }else{
                return .empty()
            }
        case let .emojiBtnClick(idx,indexPath,status):
            return postEmoji(idx: idx,indexPath: indexPath, status: status)
            
        case .refreshDataLoad:
            print("refresh")
            return .empty()
        }
    }
}
//MARK: - reduce
extension MainReactor{
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation{
        case .updateDataSource(let sectionItem):
            state.mainSection.items.append(contentsOf: sectionItem)
        case let .postEmoji(indexPath):
            state.mainSection.items[indexPath]
            print("\(state.mainSection.items[indexPath])")
        case let .deleteEmoji(indexPath):
            print("\(state.mainSection.items[indexPath])")
        }
        return state
    }
}
//MARK: - Get
private extension MainReactor{
    private func getAlgorithm() -> Observable<Mutation>{
        self.currentPage += 1
        let algorithmRequest = AlgorithmRequest(page: currentPage)
        return self.provider.userService.getAlgorithm(algorithmRequest: algorithmRequest)
            .map{(algorithm: Algorithm) -> [MainSection.Item] in
                let mainSectionItem = algorithm.data.data.map(MainSection.Item.main)
                return mainSectionItem
            }
            .map(Mutation.updateDataSource)
    }
}

//MARK: - Emoji
private extension MainReactor{
    private func postEmoji(idx : Int,indexPath : Int,status : Bool) -> Observable<Mutation>{
        let emojiRequest = EmojiRequest(number: idx)
        if status{
            return self.provider.userService.postEmoji(emojiRequest: emojiRequest)
                .map(Mutation.postEmoji(indexPath: indexPath))
        }else{
            return self.provider.userService.deleteEmoji(emojiRequest: emojiRequest)
                .map(Mutation.deleteEmoji(indexPath: indexPath))
        }
    }
}
