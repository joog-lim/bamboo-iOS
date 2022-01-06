//
//  ViewExt.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/12/05.
//

import UIKit
import SnapKit

//MARK: - UIView roundCornerRadius extension
extension UIView {
    func roundCorners(cornerRadius: CGFloat, maskedCorners: CACornerMask) {
        clipsToBounds = true
        layer.cornerRadius = cornerRadius
        layer.maskedCorners = CACornerMask(arrayLiteral: maskedCorners)
    }
}
//MARK: - SafeArea
extension UIView{
    var safeArea : ConstraintLayoutGuideDSL{
        return safeAreaLayoutGuide.snp
    }
}
//MARK: - AddSubView
extension UIView{
    func addSubviews(_ subviews: UIView...){
        subviews.forEach(self.addSubview)
    }
}

