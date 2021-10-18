//
//  ManagerStatusMenuCollectionView.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/10/06.
//

import UIKit
import Pods_bamboo_iOS

class ManagerStatusMenuCollectionView : BaseCollectionViewCell<ManagerData.status>{
    static let identifier = "ManagerStatusMenuCollectionView"
    let menuLabel = UILabel().then{
        $0.dynamicFont(fontSize: 11, currentFontName: "NanumSquareRoundB")
        $0.textColor = .lightGray
    }
    override var isSelected: Bool{
        didSet{
            self.menuLabel.textColor = isSelected ? UIColor.bamBoo_57CC4D : .lightGray
        }
    }
    
    //MARK: - LifeCycle
    override func configure() {
        super.configure()
        addSubView()
        location()
    }
    private func addSubView(){
        contentView.addSubview(menuLabel)
    }
    private func location(){
        menuLabel.snp.makeConstraints{
            $0.center.equalToSuperview()
        }
    }
    
    override func bind(_ model: ManagerData.status) {
        super.bind(model)
        menuLabel.text = model.rawValue
    }
}
