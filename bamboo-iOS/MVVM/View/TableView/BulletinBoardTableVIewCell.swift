//
//  BulletinBoardTableVIewCell.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/09/14.
//

import UIKit
class BulletinBoardTableVIewCell: UITableViewCell {
    
    static let identifier = "BulletinBoardTableVIewCell"
    
    lazy var view = UIView().then{
        $0.backgroundColor = .white
        $0.layer.applySketchShadow(color: .black, alpha: 0.25, x: -1, y: 1, blur: 4, spread: 0)
    }
    let cellTitle = UILabel().then{
        $0.dynamicFont(fontSize: 15, currentFontName: "NanumSquareRoundR")
        $0.textColor = .rgb(red: 87, green: 204, blue: 77)
    }
    let dateLabel = UILabel().then{
        $0.dynamicFont(fontSize: 11, currentFontName: "NanumSquareRoundR")
        $0.textColor = .lightGray
    }
    let tagLabel = UILabel().then{
        $0.dynamicFont(fontSize: 13, currentFontName: "NanumSquareRoundR")
        $0.textColor = .rgb(red: 87, green: 204, blue: 77)

    }
    let writeTitleLabel = UILabel().then{
        $0.dynamicFont(fontSize: 13, currentFontName: "NanumSquareRoundB")
        $0.textColor = .black
    }
    let contentTv = UITextView().then{
        $0.dynamicFont(fontSize: 13, currentFontName: "NanumSquareRoundR")
        $0.textColor = .black
        $0.text = "새벽 코딩이 개꿀임. 진심 집중도 잘 되고 뭔가 날 방해하는 것도 없어. 이걸 참아??????????????????? 가능???????????"
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(view)
        view.addSubview(cellTitle)
        view.addSubview(dateLabel)
        view.addSubview(tagLabel)
        view.addSubview(writeTitleLabel)
        view.addSubview(contentTv)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        view.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview().inset(frame.width/18.75)
            make.bottom.equalTo(contentTv.snp.bottom)
        }
        cellTitle.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp.top)
            make.left.equalTo(view.snp.left).offset(frame.width/32.5)
        }
        dateLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(cellTitle.snp.centerY)
            make.left.equalTo(cellTitle.snp.right).offset(frame.width/65)
        }
        tagLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.right.equalToSuperview().inset(frame.width/31.25)
        }
        writeTitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(cellTitle.snp.bottom)
            make.left.equalTo(cellTitle)
        }
        contentTv.snp.makeConstraints { (make) in
            make.top.equalTo(writeTitleLabel.snp.bottom)
            make.left.equalTo(cellTitle)
            make.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
