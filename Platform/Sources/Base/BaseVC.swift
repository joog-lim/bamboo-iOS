import UIKit
import ReactorKit
import RxSwift

public class BaseVC<T: Reactor> : UIViewController{
    let bound = UIScreen.main.bounds
    public var disposeBag: DisposeBag = .init()

    init(reactor : T){
            super.init(nibName: nil, bundle: nil)
            self.reactor = reactor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit{
        print("\(type(of: self)): \(#function)")
    }
    
    func bindView(reactor: T){}
    func bindAction(reactor: T){}
    func bindState(reactor: T){}
}
extension BaseVC: View{
    public func bind(reactor: T) {
        bindView(reactor: reactor)
        bindAction(reactor: reactor)
        bindState(reactor: reactor)
    }
}
