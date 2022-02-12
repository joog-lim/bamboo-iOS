//
//  NoWifiModalReactor.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2022/01/05.
//

import ReactorKit
import RxFlow
import RxCocoa

final class NoWifiModalReactor : Reactor , Stepper{
    var disposeBag : DisposeBag = .init()
    
    var steps: PublishRelay<Step> = .init()
    
    enum Action{
        case timerStart
    }
    enum Mutation{

    }
    struct State{
        
    }
    let initialState: State
    
    init(){
        self.initialState = State()
    }
}

//MARK: - Mutation
extension NoWifiModalReactor{
    func mutate(action: Action) -> Observable<Mutation> {
        switch action{
        case .timerStart:
            fetchTime()
            return .empty()
        }
    }
}

//MARK: - Method
private extension NoWifiModalReactor{
    func fetchTime(){
        let countdown = 2
        Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
            .map { countdown - $0 }
            .take(countdown + 1)
            .subscribe(onNext: { value in
                print(value)
            }, onCompleted: {
                print("completed")
                self.steps.accept(BambooStep.dismiss)
            }).disposed(by: disposeBag)
    }
}
