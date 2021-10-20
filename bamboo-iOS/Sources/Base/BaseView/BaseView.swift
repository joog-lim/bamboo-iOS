//
//  BaseView.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/10/19.
//

import UIKit

class BaseView : UIView{
    
    @available(*,unavailable)
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configure(){}
    
}
