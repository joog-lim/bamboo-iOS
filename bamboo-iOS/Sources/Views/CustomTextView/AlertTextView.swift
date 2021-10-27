//
//  AlertTextView.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/10/01.
//

import UIKit

class AlertTextView : UITextView{
    init(placeholder : String, fontSize : Int){
        super.init(frame: CGRect.zero, textContainer: nil)
        textColor = .rgb(red: 196, green: 196, blue: 196)
        textAlignment = .left
        
        backgroundColor = .white
        layer.applySketchShadow(color: .black, alpha: 0.25, x: 1, y: 1, blur: 4, spread: 0)
        layer.cornerRadius = 5
        text = placeholder
        isEditable = true
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
