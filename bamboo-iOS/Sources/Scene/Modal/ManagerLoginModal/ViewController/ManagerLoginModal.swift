//
//  ManagerLoginModal.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/11/02.
//

import UIKit

class ManagerLoginModal: BaseVC{
    //MARK: - Properties
    private let transParentsView = UIView().then{
        $0.backgroundColor = .lightGray.withAlphaComponent(0.1)
    }
    private let bgView = UIView().then{
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 5
    }
    
    //MARK: - Helper
    override func configure() {
        super.configure()
        view.backgroundColor = .clear
    }
    //MARK: - AddView
    private func addView(){
        [transParentsView,bgView].forEach{ view.addSubview($0)}
    }
    
}
