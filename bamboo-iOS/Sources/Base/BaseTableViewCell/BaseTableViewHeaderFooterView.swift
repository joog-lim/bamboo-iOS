//
//  BaseTableViewHeaderFooterView.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2022/01/10.
//

import UIKit
import Reusable

class BaseTableViewHeaderFooterView<T>: UITableViewHeaderFooterView,Reusable{

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configure()
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var model: T? {
        didSet {
            if let model = model {
                bind(model)
            }
        }
    }

    func configure() {}
    func bind(_ model: T) {}
}
