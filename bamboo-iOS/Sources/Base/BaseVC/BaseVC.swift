//
//  BaseViewController.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/10/05.
//

import UIKit
import RxViewController
import RxSwift
import ReactorKit

class baseVC<T: Reactor>: UIViewController{
    let bounds = UIScreen.main.bounds
    var disposeBag: DisposeBag = .init()
    
    var didSetupViewConstraints = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBackgroundIfNotSet()
        
        addView()
        setLayout()
        configureUI()
        keyBoardLayout()
    }
    
    init(reactor: T){
        super.init(nibName: nil, bundle: nil)
        self.reactor = reactor
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupBackgroundIfNotSet(){
        if self.view.backgroundColor == nil{
            self.view.backgroundColor = .white
        }
    }
    
    //MARK: - Override Point
    func addView(){}
    func setLayout(){}
    func configureUI(){}
    func keyBoardLayout(){}
    
    //MARK: - Bind
    func bindView(reactor: T){}
    func bindAction(reactor: T){}
    func bindState(reactor: T){}
}

extension baseVC: View{
    func bind(reactor: T) {
        bindView(reactor: reactor)
        bindAction(reactor: reactor)
        bindState(reactor: reactor)
    }
}
