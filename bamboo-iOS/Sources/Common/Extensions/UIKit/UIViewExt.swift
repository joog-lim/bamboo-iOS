//
//  UIViewExt.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2022/01/02.
//

import UIKit

extension UIView{
    func addSubviews(_ subviews: UIView...){
        subviews.forEach(self.addSubview)
    }
}
