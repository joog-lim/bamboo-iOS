import UIKit

extension UIView{
    func addSubViews(_ subView: UIView...) {
        subView.forEach(addSubview(_:))
    }
}

