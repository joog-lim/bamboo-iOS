//
//  ExplanationLabel.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/09/27.
//

import UIKit

class ExplanationLabel : UILabel{
    
    init(textLabel : String, fontSize : CGFloat, fontStyle: String) {
        super.init(frame: .zero)
        dynamicFont(fontSize: fontSize, currentFontName: fontStyle)
        textColor = .black
        numberOfLines = 0
        text = textLabel
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
