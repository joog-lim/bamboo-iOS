import UIKit

public extension UIFont{
    enum Family: String {
        case Bold = "B"
        case ExtraBold = "EB"
        case Light = "L"
        case Regular = "R"
    }
    
    static func bamboo(size: CGFloat, family: Family) -> UIFont! {
        return UIFont(name: "NanumSquareRound\(family)", size: size)
    }
}
