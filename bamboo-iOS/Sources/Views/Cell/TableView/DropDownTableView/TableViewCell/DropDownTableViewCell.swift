//
//  DropDownTableViewCell.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/10/01.
//

import UIKit

class DropDownTableViewCell : BaseTableViewCell<Data.tag>{
    static let identifier = "DropDownTableViewCell"
    
    private  let cellListTitle = UILabel().then{
        $0.font = UIFont(name: "NanumSquareRoundR", size: 11)
        $0.textColor = .black
    }
    override func configure() {
        super.configure()
        contentView.backgroundColor = .white
        contentView.layer.borderColor = UIColor.bamBoo_57CC4D.cgColor
        contentView.layer.borderWidth = 0.5
        addSubviews()
        location()
    }
    private func addSubviews(){
        contentView.addSubview(cellListTitle)
    }
    private func location(){
        cellListTitle.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    override func bind(_ model: Data.tag) {
        super.bind(model)
        cellListTitle.text = "#" + model.rawValue
    }
}
