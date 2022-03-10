//
//  BulletinBoardsTableViewCell.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/09/28.
//

import UIKit
import RxSwift
import RxCocoa

protocol ClickReportBtnActionDelegate : AnyObject{
    func clickReportBtnAction(cell : BulletinBoardsTableViewCell, id : Int)
}

final class BulletinBoardsTableViewCell : BaseTableViewCell<Algorithm.Datas.Results>{
    //MARK: - Delegate
    weak var delegate : ClickReportBtnActionDelegate?
    
    //MARK: - Properties
    private let  view = UIView().then{
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 5
    }
    private let algorithm = UILabel().then{
        $0.font = UIFont(name: "NanumSquareRoundB", size: 13)
        $0.textColor = .bamBoo_57CC4D
    }
    private let  dataLabel = UILabel().then{
        $0.font = UIFont(name: "NanumSquareRoundR", size: 11)
        $0.textColor = .lightGray
    }
    private let tagLabel = UILabel().then{
        $0.font = UIFont(name: "NanumSquareRoundR", size: 11)
        $0.textColor = .bamBoo_57CC4D
    }
    private let titleLabel = UILabel().then{
        $0.font = UIFont(name: "NanumSquareRoundB", size: 13)
        $0.textColor = .black
    }
    private let contentLabel = UILabel().then{
        $0.numberOfLines = 0
        $0.font = UIFont(name: "NanumSquareRoundR", size: 13)
        $0.textColor = .black
    }
    private let cellSettingbtn = UIButton().then{
        $0.setTitle("신고", for: .normal)
        $0.setTitleColor(.systemRed, for: .normal)
        $0.titleLabel?.font = UIFont(name: "NanumSquareRoundR", size: 11)
    }
    private let footerView = UIView()
    

    
    //MARK: - Configure
    override func configure() {
        super.configure()
        addSubviews()
        location()
        contentView.layer.applySketchShadow(color: .black, alpha: 0.25, x: -1, y: 1, blur: 4, spread: 0)
    }

    //MARK: - AddSubView
    private func addSubviews(){
        contentView.addSubview(view)
        view.addSubviews(algorithm,dataLabel,tagLabel,titleLabel,contentLabel,footerView,cellSettingbtn)
    }
    
    
    //MARK: - Location(나중 정리 예정)
    private func location(){
        view.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.left.right.equalToSuperview().inset(bounds.width/18.75)
            make.bottom.equalToSuperview().inset(5)
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
        }
        footerView.snp.makeConstraints{
            $0.top.equalTo(contentLabel.snp.bottom)
            $0.height.equalTo(bounds.width/7.5)
            $0.width.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    
    //MARK: - bind
    override func bind(_ model: Algorithm.Datas.Results) {
        algorithm.text = "#\(model.algorithmNumber)번 알고리즘"
        dataLabel.text = Date().usingDate(time: model.createdAt)
        tagLabel.text = model.tag
        titleLabel.text = model.title
        contentLabel.text = model.content

    }
    
    override func bindAction(_ model: Algorithm.Datas.Results) {
        cellSettingbtn.rx.tap
            .subscribe({[weak self] _ in
                self?.delegate?.clickReportBtnAction(cell: self!, id: model.idx)
            }).disposed(by: disposeBag)
    }
}
