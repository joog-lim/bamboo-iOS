//
//  MainReactor.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/12/06.
//
import ReactorKit
import RxFlow
import RxCocoa
import Differentiator

final class MainReactor : Reactor, Stepper{
    //MARK: - Stepper
    var steps: PublishRelay<Step> = .init()

    //MARK: - Event
    enum Action{
        case viewDidLoad
        case writeData
        case emojiBtnClick(idx : Int,state : Bool)
        case reportBtnClickAction(idx : Int, index : Int)
        case pagination(
            contentHeight: CGFloat,
            contentOffsetY: CGFloat,
            scrollViewHeight: CGFloat
        )
    }
    enum Mutation{
        case updateDataSource([MainSection.Item])
        case postAlgorithm
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
    var ispaginating = false
    let initialState = State()
        
    init(provider : ServiceProviderType){
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
        case let .emojiBtnClick(idx,status):
            return postEmoji(idx: idx, status: status)
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
        case .postAlgorithm:
            print("post Algorithm")
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

//MARK: - PostEmoji
private extension MainReactor{
    private func postEmoji(idx : Int,status : Bool) -> Observable<Mutation>{
        let emojiRequest = EmojiRequest(number: idx)
        if status{
            return self.provider.userService.postEmoji(emojiRequest: emojiRequest)
                .map(Mutation.postAlgorithm)
        }else{
            return self.provider.userService.postEmoji(emojiRequest: emojiRequest)
                .map(Mutation.postAlgorithm)
        }
    }
}
