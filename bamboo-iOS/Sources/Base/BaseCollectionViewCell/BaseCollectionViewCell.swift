//
//  BaseCollectionViewCell.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/10/17.
//

import UIKit

class BaseCollectionViewCell<T>: UICollectionViewCell{
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configure(){ }
    var model : T{
        didSet{if let model = model { bind(model) }}
    }
    func bind(_ model : T){}
    

}
