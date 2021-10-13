//
//  ManagerTableViewCell.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/10/06.
//

import UIKit

class AcceptManagerTableViewCell : BaseTableViewCell<Data>{
    //MARK: - Identifier
    static let identifier = "AcceptManagerTableViewCell"
    
    //MARK: - Properties
    private lazy var view = UIView()
    
    private lazy var algorithm = UILabel().then{
        $0.dynamicFont(fontSize: 12, currentFontName: "NanumSquareRoundB")
        $0.textColor = .bamBoo_57CC4D
    }
    private lazy var dataLabel = UILabel().then{
        $0.dynamicFont(fontSize: 9, currentFontName: "NanumSquareRoundR")
        $0.textColor = .lightGray
    }
    private lazy var modifyBtn = UIButton().then{
        $0.setTitle("수정", for: .normal)
        $0.dynamicFont(fontSize: 10, currentFontName: "NanumSquareRoundR")
        $0.setTitleColor(.lightGray, for: .normal)
    }
    private lazy var tagLabel = UILabel().then{
        $0.dynamicFont(fontSize: 10, currentFontName: "NanumSquareRoundR")
        $0.textColor = .bamBoo_57CC4D
    }
    private lazy var titleLabel = UILabel().then{
        $0.dynamicFont(fontSize: 10, currentFontName: "NanumSquareRoundB")
        $0.textColor = .black
    }
    private lazy var contentLabel = UILabel().then{
        $0.numberOfLines = 0
        $0.dynamicFont(fontSize: 10, currentFontName: "NanumSquareRoundR")
        $0.textColor = .black
    }
    
    //MARK: - layoutSubview
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: bounds.width/18.75, bottom: 5, right: bounds.width/18.75   ))
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
        view.addSubview(algorithm)
        view.addSubview(dataLabel)
        view.addSubview(tagLabel)
        view.addSubview(titleLabel)
        view.addSubview(contentLabel)
        view.addSubview(modifyBtn)
    }
    private func location(){
        view.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.right.equalToSuperview().inset(bounds.width/34)
            make.bottom.equalToSuperview()
        }
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
        modifyBtn.snp.makeConstraints {
            $0.right.equalToSuperview()
            $0.top.equalTo(algorithm)
        }
        titleLabel.snp.makeConstraints {
            $0.left.equalTo(algorithm)
            $0.top.equalTo(algorithm.snp.bottom).offset(bounds.width/37.5)
        }
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(bounds.width/53.57)
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview().inset(6)
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
