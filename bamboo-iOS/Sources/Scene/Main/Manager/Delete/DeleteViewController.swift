//
//  DeleteViewController.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/10/18.
//

import UIKit
import Reusable

import RxDataSources

final class DeleteViewController : baseVC<DeleteReactor>{
    //MARK: - Properties
    private var isLoaing : Bool = false
    
    private let titleLabel = UILabel().then{
        $0.font = UIFont(name: "NanumSquareRoundB", size: 20)
        $0.text = "삭제"
        $0.textColor = .red
    }

    private let mainTableView = UITableView().then {
        $0.register(cellType: DeleteTableViewCell.self)
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
        navigationItem.applyImageNavigation()

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

    //MARK: - TableViewHeaderSetting
    private func tableViewHeaderSetting(){
        mainTableView.tableHeaderView = tableViewHeader
        mainTableView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.centerY.equalTo(tableViewHeader)
            $0.left.equalToSuperview().offset(bounds.width/18.75)
        }
    }

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
    
    //MARK: - Bind
    override func bindAction(reactor: DeleteReactor) {
        self.rx.viewDidLoad
            .map{ _ in Reactor.Action.viewDidLoad}
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    override func bindState(reactor: DeleteReactor) {
        let dataSource = RxTableViewSectionedReloadDataSource<DeleteViewSection>{ dataSource,tableView,indexPath,sectionItem in
            switch sectionItem{
            case .main(let reactor):
                let cell = tableView.dequeueReusableCell(for: indexPath) as DeleteTableViewCell
                cell.reactor = reactor
                cell.delegate = self
                return cell
            }
        }
        reactor.state
            .map{ $0.mainSection}
            .bind(to: self.mainTableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
}

//MARK: - Cell 안에 있는 더보기 버튼 눌렀을때 Action
extension DeleteViewController : cellSeeMoreDetailActionDelegate{
    func clickSeeMoreDetailBtnAction(cell: DeleteTableViewCell, id: Int) {
        guard let indexPath = self.mainTableView.indexPath(for: cell) else{ return }
        reactor?.steps.accept(BambooStep.alert(titleText: "선택", message: "게시물을 삭제 하시겠습니까?", idx: id ,index: indexPath.row))
    }
}
