import UIKit
import ReactorKit
import RxSwift

open class BaseVC<T: Reactor> : UIViewController{
    public let bound = UIScreen.main.bounds
    public var disposeBag: DisposeBag = .init()

    public override func viewDidLoad() {
        setupBackgroundIfNotSet()
        addView()
        configureUI()
        keyBoardLayout()
    }
    
    public init(reactor : T?){
            super.init(nibName: nil, bundle: nil)
            self.reactor = reactor
    }
    @available(*, unavailable)
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setLayout()
    }
    
    deinit{
        print("\(type(of: self)): \(#function)")
    }
    
    //MARK: - Method
    private func setupBackgroundIfNotSet(){
        if self.view.backgroundColor == nil{
            self.view.backgroundColor = .white
        }
    }
    open func addView(){}
    open func setLayout(){}
    open func configureUI(){}
    open func keyBoardLayout(){}
    
    open func bindView(reactor: T){}
    open func bindAction(reactor: T){}
    open func bindState(reactor: T){}
}
extension BaseVC: View{
    public func bind(reactor: T) {
        bindView(reactor: reactor)
        bindAction(reactor: reactor)
        bindState(reactor: reactor)
    }
}
