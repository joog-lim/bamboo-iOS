//
//  LoginButton.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/09/08.
//

import UIKit

class LoginButton: UIButton {
    let label = UILabel().then{
        $0.textColor = .white
        $0.dynamicFont(fontSize: 15, currentFontName: "NanumSquareRoundR")
    }
    init(placeholder : String, cornerRadius : CGFloat) {
        super.init(frame: .zero)
        label.text = placeholder
        self.backgroundColor = .rgb(red: 87, green: 204, blue: 77)
        layer.cornerRadius = cornerRadius
        addSubview(label)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.applySketchShadow(color: .rgb(red: 87, green: 204, blue: 77), alpha: 0.25, x: 1, y: 5, blur: 5, spread: 0)

        label.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
