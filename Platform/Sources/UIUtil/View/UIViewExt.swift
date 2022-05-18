import UIKit

public extension UIView{
    func addSubViews(_ subView: UIView...) {
        subView.forEach(addSubview(_:))
    }
    
    convenience  init(frame : CGSize, backgroundColor: UIColor) {
        self.init()
        self.frame.size = frame
        self.backgroundColor = backgroundColor
    }
}

