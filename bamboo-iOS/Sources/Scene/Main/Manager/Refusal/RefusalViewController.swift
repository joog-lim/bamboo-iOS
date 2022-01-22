//
//  RefusalViewController.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/10/18.
//

import UIKit
import Reusable

import RxDataSources

final class RefusalViewController : baseVC<RefusalReactor>{
    //MARK: - Properties
    private var isLoaing : Bool = false
    
    private let titleLabel = UILabel().then{
        $0.font = UIFont(name: "NanumSquareRoundB", size: 20)
        $0.text = "거절"
        $0.textColor = .systemRed
    }
    //MARK: - TableView
    private let mainTableView = UITableView().then {
        $0.register(cellType: RefusalTableViewCell.self)
        $0.showsVerticalScrollIndicator = false
        $0.separatorColor = .clear
        $0.allowsSelection = false
        $0.rowHeight = UITableView.automaticDimension
        $0.estimatedRowHeight = 300
    }
    private lazy var tableViewHeader = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: bounds.height/10.15))
    private lazy var tableViewFooter = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: bounds.height/20))
    
    //MARK: - Action
    private func cellinsideRefusalCancelBtnClick(indexPath : Int){
        print("거절취소")
        print(indexPath)
        mainTableView.reloadData()
    }

    //MARK: - Helper
    override func configureUI() {
        super.configureUI()
        //navigationBar
        navigationItem.applyImageNavigation()
        //tableView
        tableViewHeaderSetting()
        tableFooterViewSetting()
        mainTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 0)
        mainTableView.selectRow(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .top)
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


    //MARK: - Header
    private func tableViewHeaderSetting(){
        mainTableView.tableHeaderView = tableViewHeader
        mainTableView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.centerY.equalTo(tableViewHeader)
            $0.left.equalToSuperview().offset(bounds.width/18.75)
        }
    }
    //MARK: - Footer
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

    //MARK: - bind
    override func bindAction(reactor: RefusalReactor) {
        self.rx.viewDidLoad
            .map{_ in Reactor.Action.viewDidLoad}
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }

    override func bindState(reactor: RefusalReactor) {
        let dataSource = RxTableViewSectionedReloadDataSource<RefusalSection.Model>{ dataSource, tableView, indexPath, sectionItem in
            switch sectionItem{
            case .main(let algorithm):
                let cell = tableView.dequeueReusableCell(for: indexPath) as RefusalTableViewCell
                cell.delegate = self
                cell.model = algorithm
                return cell
            }
        }
        self.mainTableView.rx.didEndDragging
            .withLatestFrom(self.mainTableView.rx.contentOffset)
            .map{ [weak self] in
                Reactor.Action.pagination(
                    contentHeight: self?.mainTableView.contentSize.height ?? 0,
                    contentOffsetY: $0.y,
                    scrollViewHeight: UIScreen.main.bounds.height
                )
            }
            .bind(to:  reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state.map(\.mainSection)
            .distinctUntilChanged()
            .map(Array.init(with: ))
            .bind(to: self.mainTableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
}

extension RefusalViewController : RefusalCancelBtnDelegate{
    func refusalCancelBtnAction(cell: RefusalTableViewCell, id: Int) {
        guard let indexPath = self.mainTableView.indexPath(for: cell) else{ return }
        mainTableView.reloadData()
       print( MainSection.Item.main)
        self.cellinsideRefusalCancelBtnClick(indexPath: indexPath.item)
    }
}
