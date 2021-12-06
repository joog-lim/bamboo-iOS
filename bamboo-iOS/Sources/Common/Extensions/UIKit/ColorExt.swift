//
//  ColorExt.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/12/05.
//

import UIKit

// MARK: - BamBoo_ reuse color extension
extension UIColor{
    static func rgb(red: CGFloat ,green: CGFloat,blue:CGFloat) -> UIColor{
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
    static func rgba(red: CGFloat ,green: CGFloat,blue:CGFloat, alpha:CGFloat) -> UIColor{
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
    }
    static let bamBoo_57CC4D = rgb(red: 87, green: 204, blue: 77)
    
}
