//
//  ManagerStatusDropDownTableViewCell.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/10/06.
//

import UIKit

class ManagerStatusDropDownTableViewCell : BaseTableViewCell<ManagerData.status>{
    static let identifier = "ManagerStatusDropDownTableViewCell"
    
    let titleLabel = UILabel().then{
        $0.dynamicFont(fontSize: 9, currentFontName: "NanumSquareRoundR")
        $0.textColor = .black
    }
    
    let checkList = UIImageView().then{
        $0.image = UIImage(named: "BAMBOO_Check")?.withRenderingMode(.alwaysTemplate)
        $0.contentMode = .scaleAspectFit
        $0.tintColor = .bamBoo_57CC4D
    }
    
    override func configure() {
        super.configure()
        contentView.backgroundColor = .white
        contentView.layer.borderWidth = 0.5
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        addView()
        location()
    }
    private func addView(){
        [titleLabel,checkList].forEach { contentView.addSubview($0)}
    }
    private func location(){
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
        }
        checkList.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(5)
            make.height.width.equalTo(10)
        }
        
    }
    override func bind(_ model: ManagerData.status) {
        super.bind(model)
        titleLabel.text = model.rawValue
    }
}
