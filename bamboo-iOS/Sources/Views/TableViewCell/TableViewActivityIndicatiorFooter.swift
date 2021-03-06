//
//  TableViewActivityIndicatiorFooter.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2022/01/13.
//

import Foundation
import UIKit
import Reusable

class CustomFooterView : BaseTableViewHeaderFooterView<Void>{
    
    private lazy var activityIndicator = UIActivityIndicatorView()
    
    override func configure() {
        super.configure()
        contentView.addSubviews(activityIndicator)
        activityIndicator.snp.makeConstraints{
            $0.center.equalToSuperview()
        }
        start()
    }
    
    func start(){
        activityIndicator.startAnimating()
    }
    func stop(){
        activityIndicator.stopAnimating()
    }
}
