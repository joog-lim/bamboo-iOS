//
//  TableViewActivityIndicatiorFooter.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2022/01/13.
//

import Foundation
import UIKit
import Reusable

class CustomFooterView : UITableViewHeaderFooterView,Reusable{
    private let refreshControlIndicator = UIActivityIndicatorView()
    var isAnimatingFinal : Bool = false
    var currentTransform : CGAffineTransform?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addSubviews(refreshControlIndicator)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        refreshControlIndicator.snp.makeConstraints{
            $0.center.equalToSuperview()
            $0.height.width.equalTo(20)
        }
    }
    
    func setTransform(inTransform : CGAffineTransform, scaleFactor : CGFloat){
        if isAnimatingFinal{
            return
        }
        self.currentTransform = inTransform
        self.refreshControlIndicator.transform = CGAffineTransform.init(scaleX: scaleFactor, y: scaleFactor)
    }
    
    //reset the animation
    func prepareInitialAnimation(){
        self.isAnimatingFinal = false
        self.refreshControlIndicator.stopAnimating()
        self.refreshControlIndicator.transform = CGAffineTransform.init(scaleX: 0, y: 0)
    }
    
    func startAnimate() {
        self.isAnimatingFinal = true
        self.refreshControlIndicator.startAnimating()
    }
    
    func stopAnimate() {
        self.isAnimatingFinal = false
        self.refreshControlIndicator.stopAnimating()
    }
    
    //final animation to display loading
    func animateFinal() {
        if isAnimatingFinal {
            return
        }
        self.isAnimatingFinal = true
        UIView.animate(withDuration: 0.2) {
            self.refreshControlIndicator.transform = CGAffineTransform.identity
        }
    }
}
