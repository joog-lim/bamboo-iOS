import UIKit

public extension UITabBarItem{
    convenience init(title: String?, image: UIImage?){
        self.init()
        self.title = title
        self.image = image
    }
}
