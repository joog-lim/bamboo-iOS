import Swinject
import RxFlow
import ReactorKit

extension Container{
    func registerDependencies() {
        registerVC()
        registerReactor()
    }
    
    private func registerVC() {
        //MARK: - onBoarding
        self.register(OnBoardingViewController.self) { r in
            return OnBoardingViewController(reactor: r.resolve(OnBoardingReactor.self))
        }
        //MARK: - User
        self.register(HomeViewController.self) { r in
            return HomeViewController(reactor: r.resolve(HomeReactor.self))
        }
        
    }
    
    private func registerReactor() {
        //MARK: - onBoarding
        self.register(OnBoardingReactor.self) { _ in
            return OnBoardingReactor()
        }
        //MARK: - User
        self.register(HomeReactor.self) { _ in
            return HomeReactor()
        }
    }
}
