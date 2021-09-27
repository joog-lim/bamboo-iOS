//
//  BulletinBoardTableVIewCell.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/09/14.
//

import UIKit
class BulletinBoardTableVIewCell: UITableViewCell {
    
    static let identifier = "BulletinBoardTableVIewCell"
    
    let view = UIView().then{
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 5
        $0.layer.applySketchShadow(color: UIColor.black, alpha: 0.25, x: -1, y: 1, blur: 4, spread: 0)
    }
    let numberLabel = UILabel().then{
        $0.dynamicFont(fontSize: 15, currentFontName: "AppleSDGothicNeo-Bold")
        $0.textColor = .bamBoo_57CC4D
    }
    let dataLabel = UILabel().then{
        $0.dynamicFont(fontSize: 11, currentFontName: "AppleSDGothicNeo-Regular")
        $0.textColor = .lightGray
    }
    let tagLabel = UILabel().then{
        $0.dynamicFont(fontSize: 13, currentFontName: "AppleSDGothicNeo-Regular")
        $0.textColor = .bamBoo_57CC4D
    }
    let titleLabel = UILabel().then{
        $0.dynamicFont(fontSize: 13, currentFontName: "AppleSDGothicNeo-Bold")
        $0.textColor = .black
    }
    let contentLabel = UILabel().then{
        $0.numberOfLines = 0
        $0.dynamicFont(fontSize: 13, currentFontName: "AppleSDGothicNeo-Regular")
        $0.textColor = .black
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addView()
        
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
            make.top.right.left.bottom.equalToSuperview()
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
            $0.bottom.equalTo(view.snp.bottom).inset(bounds.width/62.5)
        }

    }
    override func awakeFromNib() {
        super.awakeFromNib()
        contentLabel.numberOfLines = 0
        contentLabel.dynamicFont(fontSize: 13, currentFontName: "AppleSDGothicNeo-Regular")
        contentLabel.textColor = .black
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

