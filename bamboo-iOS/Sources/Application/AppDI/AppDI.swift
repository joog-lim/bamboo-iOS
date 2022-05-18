import Swinject
import RxFlow
import ReactorKit

extension Container{
    func registerDependencies() {
        registerVC()
        registerReactor()
    }
    
    private func registerVC() {
        self.register(OnBoardingViewController.self) { r in
            return OnBoardingViewController(reactor: r.resolve(OnBoardingReactor.self))
        }
    }
    
    private func registerReactor() {
        self.register(OnBoardingReactor.self) { r in
            return OnBoardingReactor()
        }
    }
}
