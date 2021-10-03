//
//  TableViewLoadingCell.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/10/03.
//

import UIKit

class TableViewLoadingCell : UITableViewCell{
    static let identifier = "TableViewLoadingCell"
    
    let activityIndicatorView = UIActivityIndicatorView().then{
        $0.tintColor = .bamBoo_57CC4D
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(activityIndicatorView)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        activityIndicatorView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
