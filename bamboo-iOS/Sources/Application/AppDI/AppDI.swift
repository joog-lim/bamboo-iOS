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
        self.register(AcceptViewController.self) { r in
            return AcceptViewController(reactor: r.resolve(AcceptReactor.self))
        }
        self.register(StandByViewController.self) { r in
            return StandByViewController(reactor: r.resolve(StandByReactor.self))
        }
        self.register(RefusalViewController.self) { r in
            return RefusalViewController(reactor: r.resolve(RefusalReactor.self))
        }
        self.register(DeleteViewController.self) { r in
            return DeleteViewController(reactor: r.resolve(DeleteReactor.self))
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
        self.register(RuleReactor.self) { _ in
            return RuleReactor()
        }
        self.register(DetailReactor.self) { _ in
            return DetailReactor()
        }
        //MARK: - Manager
        self.register(AcceptReactor.self) { _ in
            return AcceptReactor()
        }
        self.register(StandByReactor.self) { _ in
            return StandByReactor()
        }
        self.register(RefusalReactor.self) { _ in
            return RefusalReactor()
        }
        self.register(DeleteReactor.self) { _ in
            return DeleteReactor()
        }
    }
}
