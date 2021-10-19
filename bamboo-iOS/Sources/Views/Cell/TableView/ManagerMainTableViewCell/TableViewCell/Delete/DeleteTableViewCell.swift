//
//  DeleteTableViewCell.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/10/18.
//

import UIKit

class DeleteTableViewCell : BaseTableViewCell<DeleteContent>{
    //MARK: - Identifier
    static let identifier = "DeleteTableViewCell"
    
    //MARK: - Properties
    private lazy var view = UIView()
    
    private lazy var algorithm = UILabel().then{
        $0.dynamicFont(fontSize: 12, currentFontName: "NanumSquareRoundB")
        $0.textColor = .systemRed
    }
    private lazy var dataLabel = UILabel().then{
        $0.dynamicFont(fontSize: 9, currentFontName: "NanumSquareRoundR")
        $0.textColor = .lightGray
    }
    private lazy var tagLabel = UILabel().then{
        $0.dynamicFont(fontSize: 10, currentFontName: "NanumSquareRoundR")
        $0.textColor = .bamBoo_57CC4D
    }
    private lazy var cellSettingbtn = UILabel().then{
        $0.text = "더보기"
        $0.textColor = .lightGray
        $0.dynamicFont(fontSize: 10, currentFontName: "NanumSquareRoundR")
    }
    private lazy var titleLabel = UILabel().then{
        $0.dynamicFont(fontSize: 10, currentFontName: "NanumSquareRoundB")
        $0.textColor = .black
    }
    private lazy var contentLabel = UILabel().then{
        $0.numberOfLines = 10
        $0.dynamicFont(fontSize: 10, currentFontName: "NanumSquareRoundR")
        $0.textColor = .black
    }
    private lazy var deleteReasonTitle = UILabel().then{
        $0.dynamicFont(fontSize: 12, currentFontName: "NanumSquareRoundB")
        $0.text = "삭제요청사유"
        $0.textColor = .black
    }
    private lazy var deleteReasonContent = UILabel().then{
        $0.dynamicFont(fontSize: 10, currentFontName: "NanumSquareRoundR")
        $0.text = "집집집집집집집집집집집집집집집집집집집집집집집집집집집집"
        $0.numberOfLines = 0
        $0.textColor = .black
    }

    //MARK: - Configure
    override func configure() {
        super.configure()
        contentView.backgroundColor = .white
        contentView.layer.applySketchShadow(color: .black, alpha: 0.25, x: -1, y: 1, blur: 4, spread: 0)
        contentView.layer.cornerRadius = 5
        addSubviews()
        location()
    }
    private func addSubviews(){
        contentView.addSubview(view)
        [algorithm,dataLabel,tagLabel,cellSettingbtn,titleLabel,contentLabel].forEach { view.addSubview($0)}
    }
    private func location(){
        view.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.right.equalToSuperview().inset(bounds.width/29)
            make.bottom.equalToSuperview()
        }
        algorithm.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
        }
        dataLabel.snp.makeConstraints {
            $0.centerY.equalTo(algorithm)
            $0.centerX.equalToSuperview()
        }
        tagLabel.snp.makeConstraints{
            $0.top.equalTo(algorithm)
            $0.right.equalTo(cellSettingbtn.snp.left).inset(bounds.width/29 * -1)
        }
        cellSettingbtn.snp.makeConstraints {
            $0.top.equalTo(algorithm)
            $0.right.equalToSuperview()
        }
        titleLabel.snp.makeConstraints {
            $0.left.equalTo(algorithm)
            $0.top.equalTo(algorithm.snp.bottom).offset(bounds.width/37.5)
        }
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(bounds.width/53.57)
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview().inset(7)
        }
    }
    //MARK: - bind로 데이터 넘겨줌
    override func bind(_ model: DeleteContent) {
        super.bind(model)
        algorithm.text = "#\(model.numberOfAlgorithm)번째 삭제요청"
        dataLabel.text = model.data
        tagLabel.text = "#" +  model.tag.rawValue
        titleLabel.text = model.title
        contentLabel.text = model.content
        deleteReasonContent.text = model.deleteContente
    }
}


