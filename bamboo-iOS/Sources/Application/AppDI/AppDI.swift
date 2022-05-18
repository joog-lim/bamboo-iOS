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
        self.register(RuleViewController.self) { r in
            return RuleViewController(reactor: r.resolve(RuleReactor.self))
        }
        self.register(DetailViewController.self) { r in
            return DetailViewController(reactor: r.resolve(DetailReactor.self))
        }
        //MARK: - Manager
        
        
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
        self.register(RuleReactor.self) { _ in
            return RuleReactor()
        }
        self.register(DetailReactor.self) { _ in
            return DetailReactor()
        }
        //MARK: - Manager
    }
}
