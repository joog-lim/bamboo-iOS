//
//  Extensions.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/09/08.
//

import UIKit

private let standard: CGFloat = 375
private let bound = UIScreen.main.bounds

//MARK: - TextField 재정의
extension UITextField {
      private func resizeFont(calculatedFont: UIFont?, weight: UIFont.Weight) {
          self.font = calculatedFont
          self.font = UIFont.systemFont(ofSize: calculatedFont!.pointSize, weight: weight)
    }
}

//MARK: - dateFormatter extension
extension String {
    func stringFromDate() -> String {
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = self
        dateFormatter.locale = Locale(identifier: "ko_KR")
        return dateFormatter.string(from: now)
    }
}

// MARK: - EZY_ reuse color extension
extension UIColor{
    static func rgb(red: CGFloat ,green: CGFloat,blue:CGFloat) -> UIColor{
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
    static func rgba(red: CGFloat ,green: CGFloat,blue:CGFloat, alpha:CGFloat) -> UIColor{
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
    }
    static let bamBoo_57CC4D = rgb(red: 87, green: 204, blue: 77)
    
}
extension UILabel {
    func dynamicFont(fontSize size: CGFloat, currentFontName: String = "NanumSquareRoundR", textStyle: UIFont.TextStyle = .body){
        let resize = bound.width * (size/standard)
        let f = UIFont(name: currentFontName, size: resize)!
        self.adjustsFontForContentSizeCategory = true
        self.font = UIFontMetrics(forTextStyle: textStyle).scaledFont(for: f)
    }
}
extension UIFont{
    func dynamicfont(fontSize size : CGFloat, currentFontName : String = "NanumSquareRoundB",textstyle : UIFont.TextStyle = .body) -> UIFont{
        let resize = bound.width * (size/standard)
        let f = UIFont(name: currentFontName, size: resize)!
        return f
    }
}
extension UITextField {
    func dynamicFont(fontSize size: CGFloat, currentFontName: String = "NanumSquareRoundR", textStyle: UIFont.TextStyle = .body){
        let resize = bound.width * (size/standard)
        let f = UIFont(name: currentFontName, size: resize)!
        self.adjustsFontForContentSizeCategory = true
        self.font = UIFontMetrics(forTextStyle: textStyle).scaledFont(for: f)
    }
}
extension UITextView {
    func dynamicFont(fontSize size: CGFloat, currentFontName: String = "NanumSquareRoundR", textStyle: UIFont.TextStyle = .body){
        let resize = bound.width * (size/standard)
        let f = UIFont(name: currentFontName, size: resize)!
        self.adjustsFontForContentSizeCategory = true
        self.font = UIFontMetrics(forTextStyle: textStyle).scaledFont(for: f)
    }
}
extension UIButton {
    func dynamicFont(fontSize size: CGFloat, currentFontName: String = "NanumSquareRoundR", textStyle: UIFont.TextStyle = .body){
        let resize = bound.width * (size/standard)
        let f = UIFont(name: currentFontName, size: resize)!
        self.titleLabel?.adjustsFontForContentSizeCategory = true
        self.titleLabel?.font = UIFontMetrics(forTextStyle: textStyle).scaledFont(for: f)
    }
}



//MARK: - UIView roundCornerRadius extension
extension UIView {
    func roundCorners(cornerRadius: CGFloat, maskedCorners: CACornerMask) {
        clipsToBounds = true
        layer.cornerRadius = cornerRadius
        layer.maskedCorners = CACornerMask(arrayLiteral: maskedCorners)
    }
}



//MARK: - label gradient extension
extension UILabel{
    public func updateGradientTextColor_horizontal(gradientColors: [UIColor] = [UIColor(white: 0, alpha: 0.95), UIColor(white: 0, alpha: 0.6)]){
        let size = CGSize(width: intrinsicContentSize.width, height: 1)
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        
        defer { UIGraphicsEndImageContext()}
        guard let context = UIGraphicsGetCurrentContext() else {return}
        var colors: [CGColor] = []
        for color in gradientColors{
            colors.append(color.cgColor)
        }
        guard let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(),
                                        colors: colors as CFArray,
                                        locations: nil) else {return }
        
        context.drawLinearGradient(
            gradient,
            start: CGPoint.zero,
            end: CGPoint(x: size.width, y:0),
            options: []
        )
        if let image = UIGraphicsGetImageFromCurrentImageContext(){
            self.textColor = UIColor(patternImage: image)
        }
    }
    
    public func updateGradientTextColor_vertical(gradientColors: [UIColor] = [UIColor(white: 0, alpha: 0.95), UIColor(white: 0, alpha: 0.6)]){
        let size = CGSize(width: intrinsicContentSize.width, height: intrinsicContentSize.height)
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
          
        defer { UIGraphicsEndImageContext()}
        guard let context = UIGraphicsGetCurrentContext() else {return}
        var colors: [CGColor] = []
        for color in gradientColors{
            colors.append(color.cgColor)
        }
        guard let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(),
                                        colors: colors as CFArray,
                                        locations: nil) else {return }
        
        context.drawLinearGradient(
            gradient,
            start: CGPoint.zero,
            end: CGPoint(x: 0, y: size.height),
            options: []
        )
        if let image = UIGraphicsGetImageFromCurrentImageContext(){
            self.textColor = UIColor(patternImage: image)
        }
    }
   
}

// MARK: - view gradient color extension
extension UIView {
    @discardableResult
    func applyGradient(colors: [UIColor]) -> CAGradientLayer {
        return self.applyGradient(colors: colors, locations: nil)
    }
    
    @discardableResult
    func applyGradient(colors: [UIColor], locations: [NSNumber]?) -> CAGradientLayer {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colors.map { $0.cgColor }
        gradient.locations = locations
        self.layer.insertSublayer(gradient, at: 0)
        return gradient
    }
}


//MARK: - Shadow extension
extension CALayer {
func applySketchShadow(color: UIColor = .black,alpha: Float = 0.5,x:CGFloat,y:CGFloat,blur: CGFloat,spread: CGFloat = 0){
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur/UIScreen.main.scale
        masksToBounds = false
    
        if spread == 0 {
            shadowPath = nil
        }else {
            let dx = -spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
}
//MARK: - Navigation Setting
extension UINavigationItem {
    func applyImageNavigation(){
        let iv = UIImageView(image: UIImage(named: "BAMBOO_Logo"))
        iv.snp.makeConstraints { (make) in
            make.height.equalTo(19)
            make.width.equalTo(44)
        }
        titleView = iv
    }
}

extension UINavigationController{
    func navigationCustomBar(){
        navigationBar.layer.applySketchShadow(color: .bamBoo_57CC4D, alpha: 0.25, x: 1, y: 0, blur: 10, spread: 0)
        navigationBar.isTranslucent = false
        navigationBar.shadowImage = UIImage()
        
    }
}
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
