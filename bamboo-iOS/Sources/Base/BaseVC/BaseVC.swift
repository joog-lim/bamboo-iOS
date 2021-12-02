//
//  BaseViewController.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/10/05.
//

import UIKit
import RxViewController
import RxSwift

class BaseVC: UIViewController{
    var disposeBag : DisposeBag = .init()
    
    let bounds = UIScreen.main.bounds
    @available(*,unavailable)
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configureAppear()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureWillAppear()
    }

    //MARK: - 사용가능한 메서드
    func configure(){
        view.backgroundColor = .white
    }
    func configureAppear(){}
    func configureWillAppear(){}
    
    
    
}

