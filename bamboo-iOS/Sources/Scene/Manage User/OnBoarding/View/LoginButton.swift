//
//  LoginButton.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2022/05/18.
//

import UIKit
import BamBooColor
import UIUtil

final class LoginButton: UIButton {

    init(placeholder : String, cornerRadius : CGFloat, font : UIFont) {
        super.init(frame: .zero)
        self.backgroundColor = .bambooGreen
        layer.cornerRadius = cornerRadius
        setTitle(placeholder, for: .normal)
        setTitleColor(.white, for: .normal)
        titleLabel?.font = font
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
