//
//  AlertTextField.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/09/11.
//

import UIKit

class AlertTextField : UITextField {
    
    init(placeholder : String) {
        super.init(frame: .zero)
        let spacer = UIView()
        spacer.snp.makeConstraints { (make) in
            make.height.equalToSuperview()
            make.width.equalTo(20)
        }
        leftView = spacer
        leftViewMode = .always
        
        borderStyle = .none
        textColor = .black
        keyboardAppearance = .dark
        backgroundColor = .white
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.rgb(red: 196, green: 196, blue: 196)])
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        snp.makeConstraints { (make) in
            make.height.equalTo(100)
        }
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
