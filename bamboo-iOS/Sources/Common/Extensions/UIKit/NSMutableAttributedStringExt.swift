//
//  NSMutableAttributedStringExt.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/12/05.
//

import UIKit

extension NSMutableAttributedString {
    func setColorForText(textToFind: String, withColor color: UIColor) {
        let range: NSRange = self.mutableString.range(of: textToFind, options: .caseInsensitive)
        self.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        }
    func setFontForText(textToFind: String, withFont font: UIFont
    ){
        let range : NSRange = self.mutableString.range(of: textToFind,options: .caseInsensitive)
        self.addAttribute(NSAttributedString.Key.font, value: font, range: range)
    }
}
