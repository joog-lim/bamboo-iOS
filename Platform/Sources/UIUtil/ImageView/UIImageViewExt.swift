import UIKit

public extension UIImageView{
    convenience init(image: UIImage?, contentMode : ContentMode){
        self.init()
        self.image = image
        self.contentMode = contentMode
    }
}
