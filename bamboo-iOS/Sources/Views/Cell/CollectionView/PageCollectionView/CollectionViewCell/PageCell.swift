//
//  PageCell.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/10/18.
//

import UIKit

class PageCell : UICollectionViewCell{
    //MARK: - id
    static let identifier = "PageCell"
    let vc = AcceptViewController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addView()
        location()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func addView(){
        addSubview(vc.view)
    }
    private func location(){
        vc.view.snp.makeConstraints {
            $0.top.trailing.leading.bottom.equalToSuperview()
        }
    }
}
