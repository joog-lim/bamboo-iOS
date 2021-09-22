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
        $0.dynamicFont(fontSize: 13, currentFontName: "AppleSDGothicNeo-Regular")
        $0.textColor = .black
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addView()
    }
    func addView(){
        contentView.addSubview(view)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
}

