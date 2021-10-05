//
//  BaseViewController.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/10/05.
//

import UIKit

class BaseViewController: UIViewController{
    
    let bounds = UIScreen.main.bounds

    @available(*,unavailable)
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configureAppear()
    }
    func configure(){
        view.backgroundColor = .white
    }
    func configureAppear(){ }
}
