//
//  BaseViewController.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/10/05.
//

import UIKit
import RxViewController
import RxSwift

class BaseViewController: UIViewController{
    var disposeBag : DisposeBag = .init()
    
    let bounds = UIScreen.main.bounds
    
    @available(*,unavailable)
 
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
//    self.rx.viewDidLoad
//        .subscribe(onNext:{
//        configure()
//    })
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configureAppear()
    }
    func configure(){
        view.backgroundColor = .white
    }
    func configureAppear(){ }
}
