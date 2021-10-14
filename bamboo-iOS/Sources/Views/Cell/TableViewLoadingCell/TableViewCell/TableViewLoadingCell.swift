//
//  TableViewLoadingCell.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/10/03.
//

import UIKit

class TableViewLoadingCell : UITableViewCell{
    static let identifier = "TableViewLoadingCell"
    
    let noAlgorithm = UILabel().then{
        $0.dynamicFont(fontSize: 12, currentFontName: "NanumSquareRoundR")
        $0.textColor = .lightGray
        $0.text = "더 이상 알고리즘이 없어요!"
        $0.isHidden = true
    }
    
    let activityIndicatorView = UIActivityIndicatorView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(activityIndicatorView)
        contentView.addSubview(noAlgorithm)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        activityIndicatorView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        noAlgorithm.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
