//
//  StepExt.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/12/02.
//

import RxFlow

extension Step{
    var asBambooStep: BambooStep?{
        return self as? BambooStep
    }
}
