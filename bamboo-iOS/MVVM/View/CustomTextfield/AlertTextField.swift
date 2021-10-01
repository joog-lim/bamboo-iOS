//
//  AlertTextField.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/09/11.
//

import UIKit

class AlertTextField : UITextField {
    
    init(placeholder :String,fontSize : CGFloat) {
        super.init(frame: .zero)
        spacing()
        layer.cornerRadius = 5
        dynamicFont(fontSize: fontSize, currentFontName: "NanumSquareRoundR")
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor : UIColor.rgb(red: 196, green: 196, blue: 196)])
        textColor = .black
        backgroundColor = .white
        layer.applySketchShadow(color: .black, alpha: 0.25, x: 1, y: 1, blur: 4, spread: 0)
        borderStyle = .none
    }
    //MARK: - Textfield Spacing 할 공간
    func spacing(){
        let view = UIView()
        view.snp.makeConstraints { (make) in
            make.height.equalTo(frame.height)
            make.width.equalTo(6)
        }
        rightView = view
        leftView = view
        leftViewMode = .always
        rightViewMode = .always
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
