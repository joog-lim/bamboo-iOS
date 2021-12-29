//
//  StandByViewController.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/10/18.
//

import UIKit

import RxDataSources

final class StandByViewController : baseVC<StandByReactor>{
    //MARK: - Properties
    private var isLoaing : Bool = false
    
    private let titleLabel = UILabel().then{
        $0.font = UIFont(name: "NanumSquareRoundB", size: 20)
        $0.text = "대기"
        $0.textColor = .systemYellow
    }

    private let mainTableView = UITableView().then {
        $0.register(StandByTableViewCell.self, forCellReuseIdentifier: StandByTableViewCell.reusableID)
        $0.showsVerticalScrollIndicator = false
        $0.separatorColor = .clear
        $0.allowsSelection = false
        $0.rowHeight = UITableView.automaticDimension
        $0.estimatedRowHeight = 300
    }
    private lazy var tableViewHeader = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: bounds.height/10.15))
    private lazy var tableViewFooter = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: bounds.height/20))

    //MARK: - Helper
    override func configureUI() {
        super.configureUI()
        tableViewHeaderSetting()
        tableFooterViewSetting()
        mainTableView.selectRow(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .top)
        mainTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 0)
    }
    
    override func addView() {
        super.addView()
        view.addSubview(mainTableView)
    }
    override func setLayout() {
        super.setLayout()
        mainTableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeArea.edges)
        }
    }
    
    //MARK: - TableViewHeaderSetting
    private func tableViewHeaderSetting(){
        mainTableView.tableHeaderView = tableViewHeader
        mainTableView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.centerY.equalTo(tableViewHeader)
            $0.left.equalToSuperview().offset(bounds.width/18.75)
        }
    }
    //MARK: - tableViewFooter
    private func tableFooterViewSetting(){
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.startAnimating()
        activityIndicatorView.tintColor = .lightGray
        mainTableView.tableFooterView = tableViewFooter
        mainTableView.addSubview(activityIndicatorView)
        activityIndicatorView.snp.makeConstraints { make in
            make.center.equalTo(tableViewFooter)
        }
    }
    override func bindAction(reactor: StandByReactor) {
        self.rx.viewDidLoad
            .map{_ in Reactor.Action.viewDidLoad}
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    override func bindState(reactor: StandByReactor) {
        let dataSource = RxTableViewSectionedReloadDataSource<StandByViewSection>{ dataSource, tableView, indexPath, sectionItem in
            switch sectionItem{
            case.main(let reactor):
                let cell = tableView.dequeueReusableCell(for: indexPath) as StandByTableViewCell
                cell.delegate = self
                cell.reactor = reactor
                return cell
            }
        }
        
        reactor.state
            .map{ $0.mainSection}
            .bind(to: self.mainTableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
}

//MARK: - Click Cell inside Btn Action
extension StandByViewController : StandBytableViewCellBtnClickDelegate{
    func clickSeeMoreDetailBtn(cell: StandByTableViewCell, id: String) {
        guard let indexPath = mainTableView.indexPath(for: cell) else {return}
        reactor?.steps.accept(BambooStep.alert(titleText: "선택", message: "게시물을 대기 하시겠습니까?", idx: id,index: indexPath.row))
    }
}
