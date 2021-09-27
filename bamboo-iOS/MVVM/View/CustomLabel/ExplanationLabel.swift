//
//  ExplanationLabel.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/09/27.
//

import UIKit

class ExplanationLabel : UILabel{
    
    init( fontSize : CGFloat, fontStyle: String, labelColor : UIColor) {
        super.init(frame: .zero)
        dynamicFont(fontSize: fontSize, currentFontName: fontStyle)
        textColor = labelColor
        numberOfLines = 0
        isUserInteractionEnabled = true

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
