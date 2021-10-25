//
//  LoginButton.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/09/08.
//

import UIKit

class LoginButton: UIButton {

    init(placeholder : String, cornerRadius : CGFloat) {
        super.init(frame: .zero)
        self.backgroundColor = .bamBoo_57CC4D
        layer.cornerRadius = cornerRadius
        setTitle(placeholder, for: .normal)
        setTitleColor(.white, for: .normal)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.applySketchShadow(color: .rgb(red: 87, green: 204, blue: 77), alpha: 0.25, x: 1, y: 5, blur: 5, spread: 0)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
