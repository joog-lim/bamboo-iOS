//
//  AlertTextField.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/09/11.
//

import UIKit

class AlertTextField : UITextField {
    
    init(placeholder :String) {
        super.init(frame: .zero)
        let view = UIView()
        view.snp.makeConstraints { (make) in
            make.height.equalTo(10)
            make.width.equalTo(10)
        }
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor : UIColor.rgb(red: 196, green: 196, blue: 196)])
        leftView = view
        leftViewMode = .always
        borderStyle = .none
        textColor = .black
        backgroundColor = .white
        layer.applySketchShadow(x: 1, y: 1, blur: 4)
        
    }
        

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
