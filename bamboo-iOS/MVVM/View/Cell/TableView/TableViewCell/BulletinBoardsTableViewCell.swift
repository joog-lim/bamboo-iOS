//
//  BulletinBoardsTableViewCell.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/09/28.
//

import UIKit
class BulletinBoardsTableViewCell : BaseTableViewCell<Data>{
    static let identifier = "BulletinBoardsTableVIewCell"
    
    private lazy var algorithm = UILabel().then{
        $0.dynamicFont(fontSize: 15, currentFontName: "AppleSDGothicNeo-Bold")
        $0.textColor = .bamBoo_57CC4D
    }
    private lazy var dataLabel = UILabel().then{
        $0.dynamicFont(fontSize: 11, currentFontName: "AppleSDGothicNeo-Regular")
        $0.textColor = .lightGray
    }
    private lazy var tagLabel = UILabel().then{
        $0.dynamicFont(fontSize: 13, currentFontName: "AppleSDGothicNeo-Regular")
        $0.textColor = .bamBoo_57CC4D
    }
    private lazy var titleLabel = UILabel().then{
        $0.dynamicFont(fontSize: 13, currentFontName: "AppleSDGothicNeo-Regular")
        $0.textColor = .bamBoo_57CC4D
    }
    private lazy var contentLabel = UILabel().then{
        $0.numberOfLines = 0
        $0.dynamicFont(fontSize: 13, currentFontName: "AppleSDGothicNeo-Regular")
        $0.textColor = .black
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20   ))
    }
    override func configure() {
        super.configure()
        contentView.backgroundColor = .white
        contentView.layer.applySketchShadow(color: .black, alpha: 0.25, x: -1, y: 1, blur: 4, spread: 0)
        contentView.layer.cornerRadius = 5
        addSubviews()
        location()
    }
    private func addSubviews(){
        contentView.addSubview(algorithm)
        contentView.addSubview(dataLabel)
        contentView.addSubview(tagLabel)
    }
    private func location(){
        algorithm.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
        }
        dataLabel.snp.makeConstraints {
            $0.centerY.equalTo(algorithm)
            $0.left.equalTo(algorithm.snp.right).offset(bounds.width/75)
        }
        tagLabel.snp.makeConstraints{
            $0.right.equalToSuperview()
            $0.top.equalTo(algorithm)
        }
    }
    override func bind(_ model: Data) {
        super.bind(model)
        
        algorithm.text = model.numberOfAlgorithm
        dataLabel.text = model.data
        tagLabel.text = "#" + String(describing: model.tag)
        titleLabel.text = model.title
        contentLabel.text = model.content
    }
}
