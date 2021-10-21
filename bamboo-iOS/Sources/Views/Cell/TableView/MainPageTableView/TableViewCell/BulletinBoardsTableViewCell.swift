//
//  BulletinBoardsTableViewCell.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/09/28.
//

import UIKit
class BulletinBoardsTableViewCell : BaseTableViewCell<Data>{
    //MARK: - Identifier
    static let identifier = "BulletinBoardsTableVIewCell"
    
    //MARK: - Properties
    private lazy var view = UIView().then{
        $0.backgroundColor = .white
        $0.layer.applySketchShadow(color: .black, alpha: 0.25, x: -1, y: 1, blur: 4, spread: 0)
        $0.layer.cornerRadius = 5
    }
    private lazy var algorithm = UILabel().then{
        $0.dynamicFont(fontSize: 13, currentFontName: "NanumSquareRoundB")
        $0.textColor = .bamBoo_57CC4D
    }
    private lazy var dataLabel = UILabel().then{
        $0.dynamicFont(fontSize: 11, currentFontName: "NanumSquareRoundR")
        $0.textColor = .lightGray
    }
    private lazy var tagLabel = UILabel().then{
        $0.dynamicFont(fontSize: 12, currentFontName: "NanumSquareRoundR")
        $0.textColor = .bamBoo_57CC4D
    }
    private lazy var titleLabel = UILabel().then{
        $0.dynamicFont(fontSize: 13, currentFontName: "NanumSquareRoundB")
        $0.textColor = .black
    }
    private lazy var contentLabel = UILabel().then{
        $0.numberOfLines = 0
        $0.dynamicFont(fontSize: 13, currentFontName: "NanumSquareRoundR")
        $0.textColor = .black
    }
    private lazy var footerView = UIView().then{
        $0.backgroundColor = .clear
    }
    private lazy var likeBtn = LikeOrDisLikeView(imageLikeOrDisLike: UIImage(named: "BAMBOO_Good")?.withRenderingMode(.alwaysTemplate) ).then{
        $0.iv.tintColor = .blue
    }
    private lazy var dislikeBtn = LikeOrDisLikeView(imageLikeOrDisLike: UIImage(named: "BAMBOO_Hate")?.withRenderingMode(.alwaysTemplate)).then{
        $0.iv.tintColor = .gray
    }
    
    //MARK: - Configure
    override func configure() {
        super.configure()
        addSubviews()
        location()
    }
    private func addSubviews(){
        contentView.addSubview(view)
        [algorithm,dataLabel,tagLabel,titleLabel,contentLabel,footerView,likeBtn,dislikeBtn].forEach { view.addSubview($0)}
    }
    private func location(){
        view.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview().inset(bounds.width/29)
            make.bottom.equalToSuperview()
        }
        algorithm.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalToSuperview().inset(bounds.width/29)
        }
        dataLabel.snp.makeConstraints {
            $0.centerY.equalTo(algorithm)
            $0.centerX.equalToSuperview()
        }
        tagLabel.snp.makeConstraints{
            $0.top.equalTo(algorithm)
            $0.right.equalToSuperview().inset(bounds.width/29)
        }

        titleLabel.snp.makeConstraints {
            $0.left.equalTo(algorithm)
            $0.top.equalTo(algorithm.snp.bottom).offset(bounds.width/37.5)
        }
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(bounds.width/53.57)
            $0.left.right.equalToSuperview().inset(bounds.width/29)
        }
        footerView.snp.makeConstraints{
            $0.top.equalTo(contentLabel.snp.bottom)
            $0.height.equalTo(bounds.width/7.5)
            $0.width.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        likeBtn.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(11)
            $0.right.equalTo(dislikeBtn.snp.left).offset(bounds.width/22.26 * -1)
            $0.height.equalTo(16)
            $0.width.equalTo(bounds.width/12.83)
        }
        dislikeBtn.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(11)
            $0.right.equalToSuperview().inset(bounds.width/29)
            $0.height.equalTo(16)
            $0.width.equalTo(bounds.width/12.83)
        }
    }
    //MARK: - bind로 데이터 넘겨줌
    override func bind(_ model: Data) {
        super.bind(model)
        algorithm.text = "#\(model.numberOfAlgorithm)번째 알고리즘"
        dataLabel.text = model.data
        tagLabel.text = "#" +  model.tag.rawValue
        titleLabel.text = model.title
        contentLabel.text = model.content
    }
}
