//
//  RefusalTableViewCell.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/10/18.
//

import UIKit

class RefusalTableViewCell : BaseTableViewCell<ManagerTextData>{
    //MARK: - Identifier
    static let identifier = "RefusalTableViewCell"
    
    //MARK: - Properties
    private lazy var view = UIView().then{
        $0.backgroundColor = .white
        $0.layer.applySketchShadow(color: .black, alpha: 0.25, x: -1, y: 1, blur: 4, spread: 0)
        $0.layer.cornerRadius = 5
    }
    private lazy var algorithm = UILabel().then{
        $0.font = UIFont(name: "NanumSquareRoundB", size: 13)
        $0.textColor = .systemRed
    }
    private lazy var dataLabel = UILabel().then{
        $0.font = UIFont(name: "NanumSquareRoundR", size: 12)
        $0.textColor = .lightGray
    }
    private lazy var tagLabel = UILabel().then{
        $0.font = UIFont(name: "NanumSquareRoundR", size: 11)
        $0.textColor = .bamBoo_57CC4D
    }
    let cellSettingbtn = UIButton().then{
        $0.setTitle("거절취소", for: .normal)
        $0.setTitleColor(.systemRed, for: .normal)
        $0.titleLabel?.font = UIFont(name: "NanumSquareRoundR", size: 11)
    }
    private lazy var titleLabel = UILabel().then{
        $0.font = UIFont(name: "NanumSquareRoundB", size: 13)
        $0.textColor = .black
    }
    private lazy var contentLabel = UILabel().then{
        $0.numberOfLines = 0
        $0.font = UIFont(name: "NanumSquareRoundB", size: 13)
        $0.textColor = .black
    }
    
    //MARK: - Selector

    

    //MARK: - Configure
    override func configure() {
        super.configure()
        addSubviews()
        location()
    }
    
    private func addSubviews(){
        contentView.addSubview(view)
        [algorithm,dataLabel,tagLabel,cellSettingbtn,titleLabel,contentLabel].forEach { view.addSubview($0)}
    }
    private func location(){
        view.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview().inset(bounds.width/18.75)
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
            $0.centerY.equalTo(algorithm)
            $0.right.equalTo(cellSettingbtn.snp.left).inset(bounds.width/29 * -1)
        }
        cellSettingbtn.snp.makeConstraints {
            $0.centerY.equalTo(algorithm)
            $0.height.equalTo(tagLabel.snp.height)
            $0.right.equalToSuperview().inset(bounds.width/29)
        }
        titleLabel.snp.makeConstraints {
            $0.left.equalTo(algorithm)
            $0.top.equalTo(algorithm.snp.bottom).offset(bounds.width/37.5)
        }
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(bounds.width/53.57)
            $0.left.right.equalToSuperview().inset(bounds.width/29)
            $0.bottom.equalToSuperview().inset(10)
        }
    }
    //MARK: - bind로 데이터 넘겨줌
    override func bind(_ model: ManagerTextData) {
        super.bind(model)
        algorithm.text = "#\(model.numberOfAlgorithm)번째 거절됨"
        dataLabel.text = model.data
        tagLabel.text = "#" +  model.tag.rawValue
        titleLabel.text = model.title
        contentLabel.text = model.content
    }
}


