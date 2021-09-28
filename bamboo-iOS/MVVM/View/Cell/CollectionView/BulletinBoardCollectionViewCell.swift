//
//  BulletinBoardCollectionViewCell.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/09/28.
//

import UIKit

class BulletinBoardCollectionViewCell : UICollectionViewCell{
    static let identifier = "BulletinBoardCollectionViewCell"
    
    let view = UIView().then{
        $0.backgroundColor = .white
    }
    let numberLabel = UILabel().then{
        $0.dynamicFont(fontSize: 15, currentFontName: "AppleSDGothicNeo-Bold")
        $0.textColor = .bamBoo_57CC4D
        $0.text = "#192번째 알고리즘"
    }
    let dataLabel = UILabel().then{
        $0.dynamicFont(fontSize: 11, currentFontName: "AppleSDGothicNeo-Regular")
        $0.textColor = .lightGray
        $0.text = "2021년 6월 3일"
    }
    let tagLabel = UILabel().then{
        $0.dynamicFont(fontSize: 13, currentFontName: "AppleSDGothicNeo-Regular")
        $0.textColor = .bamBoo_57CC4D
        $0.text = "#공부"
    }
    let titleLabel = UILabel().then{
        $0.dynamicFont(fontSize: 13, currentFontName: "AppleSDGothicNeo-Bold")
        $0.textColor = .black
        $0.text = "오늘 급식 뭐냐"
    }
    let contentLabel = UILabel().then{
        $0.numberOfLines = 0
        $0.dynamicFont(fontSize: 13, currentFontName: "AppleSDGothicNeo-Regular")
        $0.textColor = .black
        $0.text = "집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집"
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addView()
        contentView.backgroundColor = .white
        contentView.layer.applySketchShadow(color: .black, alpha: 0.25, x: -1, y: 1, blur: 4, spread: 0)
    }
    func addView(){
        contentView.addSubview(view)
        view.addSubview(numberLabel)
        view.addSubview(dataLabel)
        view.addSubview(tagLabel)
        view.addSubview(titleLabel)
        view.addSubview(contentLabel)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        view.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
        numberLabel.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(bounds.width/32.5)
        }
        dataLabel.snp.makeConstraints {
            $0.centerY.equalTo(numberLabel)
            $0.left.equalTo(numberLabel.snp.right).offset(bounds.width/75)
        }
        tagLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(bounds.width/31.25)
            $0.right.equalToSuperview().inset(bounds.width/31.75)
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(numberLabel.snp.bottom).offset(bounds.width/53.57)
            $0.left.equalTo(numberLabel)
            $0.right.equalToSuperview().inset(bounds.width/31.75)
        }
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(bounds.width/53.57)
            $0.left.right.equalToSuperview().inset(bounds.width/31.75)
            $0.bottom.equalToSuperview().inset(bounds.width/62.5)
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
