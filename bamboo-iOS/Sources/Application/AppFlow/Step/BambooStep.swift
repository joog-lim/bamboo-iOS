import RxSwift
import UIKit
import RxFlow

enum BambooStep : Step{
    //MARK: - Global
    case alert(title : String?, message: String?, style: UIAlertController.Style, actions: [UIAlertAction])
    case dismiss
    case popToRoot
    
    //MARK: - Manage Users
    case onBoardingIsRequired
    case loginIsRequired
    
    //MARK: - User Service
    case UserIsRequired
    case HomeIsRequired
    case RuleIsRequired
    case DetailIsRequired
    //MARK: - Manager Service
    case ManagerIsRequired
}
