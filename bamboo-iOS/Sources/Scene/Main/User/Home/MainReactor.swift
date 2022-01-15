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
        case viewWillAppear
        case writeData
        case reportBtnClickAction(idx : Int, index : Int)
        case pagination(
            contentHeight: CGFloat,
            contentOffsetY: CGFloat,
            scrollViewHeight: CGFloat
        )
    }
    enum Mutation{
        case updateDataSource([MainSection.Item])
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
        case .viewWillAppear:
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
        }
        return state
    }
}
//MARK: - GetAlgorithm
private extension MainReactor{
    private func getAlgorithm() -> Observable<Mutation>{
        self.currentPage += 1
        let algorithmRequest = AlgorithmRequest(page: currentPage, status: "ACCEPTED")
        return self.provider.userService.getAlgorithm(algorithmRequest: algorithmRequest)
            .map{(algorithm: [Algorithm]) -> [MainSection.Item] in
                let mainSectionItem = algorithm.map(MainSection.Item.main)
                return mainSectionItem
            }
            .map(Mutation.updateDataSource)
    }
}
