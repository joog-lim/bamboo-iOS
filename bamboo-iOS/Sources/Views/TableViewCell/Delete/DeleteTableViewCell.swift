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
    
    //MARK: - Delegate
    weak var delegate : cellSeeMoreDetailActionDelegate?
    
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
    private lazy var cellSeeMoreDetail = UIButton().then{
        $0.setTitle("더보기", for: .normal)
        $0.setTitleColor(.lightGray, for: .normal)
        $0.titleLabel?.font = UIFont(name: "NanumSquareRoundR", size: 11)
        $0.addTarget(self, action: #selector(clickSeeMoreDetailBtnAction), for: .touchUpInside)
    }
    private lazy var titleLabel = UILabel().then{
        $0.font = UIFont(name: "NanumSquareRoundB", size: 13)
        $0.textColor = .black
    }
    private lazy var contentLabel = UILabel().then{
        $0.numberOfLines = 0
        $0.font = UIFont(name: "NanumSquareRoundR", size: 13)
        $0.textColor = .black
    }
    private lazy var deleteReasonTitle = UILabel().then{
        $0.font = UIFont(name: "NanumSquareRoundB", size: 15)
        $0.text = "삭제요청사유"
        $0.textColor = .black
    }
    private lazy var deleteReasonContent = UILabel().then{
        $0.font = UIFont(name: "NanumSquareRoundR", size: 13)
        $0.numberOfLines = 0
        $0.textColor = .black
    }
    //MARK: - Action
    @objc private func clickSeeMoreDetailBtnAction(){
        delegate?.clickSeeMoreDetailBtnAction(cell: self)
    }
    
    //MARK: - Configure
    override func configure() {
        super.configure()
        addSubviews()
        location()
    }
    private func addSubviews(){
        contentView.addSubview(view)
        [algorithm,dataLabel,tagLabel,cellSeeMoreDetail,titleLabel,contentLabel,deleteReasonTitle,deleteReasonContent].forEach { view.addSubview($0)}
    }
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
            $0.right.equalTo(cellSeeMoreDetail.snp.left).inset(bounds.width/29 * -1)
        }
        cellSeeMoreDetail.snp.makeConstraints {
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
        deleteReasonTitle.snp.makeConstraints {
            $0.top.equalTo(contentLabel.snp.bottom).offset(10)
            $0.left.equalToSuperview().inset(bounds.width/29)
        }
        deleteReasonContent.snp.makeConstraints {
            $0.top.equalTo(deleteReasonTitle.snp.bottom).offset(10)
            $0.left.right.equalToSuperview().inset(bounds.width/29)
            $0.bottom.equalToSuperview().inset(10)
        }
    }
    //MARK: - 재사용
    override func reuse() {
        super.reuse()
        self.delegate = nil
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
//MARK: - 더보기 버튼 눌렀을때 Action Protocol
protocol cellSeeMoreDetailActionDelegate : AnyObject{
    func clickSeeMoreDetailBtnAction(cell : DeleteTableViewCell)
}
