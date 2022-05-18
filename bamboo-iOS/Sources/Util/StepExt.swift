import RxFlow

extension Step {
    var asBambooStep: BambooStep? {
        return self as? BambooStep
    }
}
