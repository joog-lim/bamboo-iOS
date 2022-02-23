//
//  OTPModalReactor.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2022/02/22.
//

import ReactorKit
import RxFlow
import RxSwift
import RxCocoa

final class OTPModalReactor : Reactor, Stepper{
    
    var disposeBag : DisposeBag = .init()
    
    var steps: PublishRelay<Step> = .init()
    
    enum Action{
        case backBtnRequired
        case refreshOTPBtnRequired
    }
    enum Mutation{
        case coundDownOTP(time:Int)
    }
    struct State{
        var time : Int?
        var minute : Int?
        var second : Int?
    }
    let initialState: State
    let provider : ServiceProviderType
    
    init(with provider : ServiceProviderType){
        self.initialState = State()
        self.provider = provider
    }
}
//MARK: - Mutate
extension OTPModalReactor{
    func mutate(action: Action) -> Observable<Mutation> {
        switch action{
        case .backBtnRequired:
            steps.accept(BambooStep.backBtnRequired)
            return .empty()
        case .refreshOTPBtnRequired:
            return fetchCoundDown()
        }
    }
}
//MARK: - Reduce
extension OTPModalReactor{
    func reduce(state: State, mutation: Mutation) -> State {
        var new = state
        switch mutation{
        case let .coundDownOTP(time):
            new.time = time
            new.minute = time/60
            new.second = time%60
        }
        return new
    }
}

//MARK: - Method
extension OTPModalReactor{
    func fetchCoundDown() -> Observable<Mutation>{
        let coundDown = 300
        return Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
            .map { coundDown - $0 }
            .take(coundDown + 1)
            .map{ timePassed in
                Mutation.coundDownOTP(time: timePassed)
            }
    }
}
