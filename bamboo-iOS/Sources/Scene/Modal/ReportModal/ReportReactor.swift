//
//  ReportReactor.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/12/16.
//

import ReactorKit
import RxFlow
import RxCocoa

final class ReportReactor: Reactor , Stepper{
    
    var disposeBag : DisposeBag = .init()
    
    var steps: PublishRelay<Step> = .init()
    
    enum Action{
        case dismissModal
        case reportBtnTap(reason : String)
    }
    enum Mutation{
        case reportPatchSuccess
    }
    struct State{
        
    }
    
    let initialState: State
    let provider : ServiceProviderType
    let idx : Int
    
    init(provider : ServiceProviderType, idx: Int){
        self.initialState = State()
        self.provider = provider
        self.idx = idx
    }
}

extension ReportReactor{
    func mutate(action: Action) -> Observable<Mutation> {
        switch action{
        case.dismissModal:
            steps.accept(BambooStep.dismiss)
            return .empty()
        case let .reportBtnTap(reason):
            return patchReport(reason: reason)
        }
    }
}

//MARK: - Method
extension ReportReactor{
    private func patchReport(reason : String) -> Observable<Mutation>{
        let reportRequest = ReportRequest(reason: reason)
        return provider.userService.patchReported(reportedRequest: reportRequest, idx: idx)
            .map(Mutation.reportPatchSuccess)
    }
}
