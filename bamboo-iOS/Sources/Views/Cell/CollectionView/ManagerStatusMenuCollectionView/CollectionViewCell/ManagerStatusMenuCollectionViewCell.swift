//
//  ManagerStatusMenuCollectionView.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/10/06.
//

import UIKit

class ManagerStatusMenuCollectionView : BaseCollectionViewCell<ManagerData.status>{
    static let identifier = "ManagerStatusMenuCollectionView"
    let menuLabel = UILabel().then{
        $0.dynamicFont(fontSize: 11, currentFontName: "NanumSquareRoundB")
        $0.textColor = .black
    }
    lazy var  view = UIView().then{
        $0.backgroundColor = .bamBoo_57CC4D
        $0.frame = CGRect(x: 0, y: contentView.frame.height - 3, width: 0, height: 0)
    }
    override var isSelected: Bool{
        didSet{
            if isSelected{
                UIView.animate(withDuration: 0.3) { [self] in
                    view.frame = CGRect(x: 0, y: contentView.frame.height - 3, width: contentView.frame.width, height: 3)
                    menuLabel.textColor = .bamBoo_57CC4D
                }
            }else{
                UIView.animate(withDuration: 0.3) { [self] in
                    view.frame = CGRect(x: 0, y: contentView.frame.height - 3, width: 0, height: 3)
                    menuLabel.textColor = .black
                }
            }
        }
    }
    
    //MARK: - LifeCycle
    override func configure() {
        super.configure()
        addSubView()
        location()
    }
    private func addSubView(){
        [menuLabel,view].forEach { contentView.addSubview($0)}
    }
    private func location(){
        contentView.backgroundColor = .white
        menuLabel.snp.makeConstraints{
            $0.center.equalToSuperview()
        }
    }
    
    override func bind(_ model: ManagerData.status) {
        super.bind(model)
        menuLabel.text = model.rawValue
    }
}
