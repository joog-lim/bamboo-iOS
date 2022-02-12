//
//  RefusalViewController.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/10/18.
//

import UIKit
import Reusable
import RxSwift
import RxDataSources

final class RefusalViewController : baseVC<RefusalReactor>{
    
    //MARK: - Properties
    private let refreshControl = UIRefreshControl().then{
        $0.tintColor = UIColor.bamBoo_57CC4D
    }
    
    private let mainTableView = UITableView(frame: .zero, style: .grouped).then {
        $0.register(headerFooterViewType: RefusalTableViewHeaderView.self)
        $0.register(cellType: RefusalTableViewCell.self)
        $0.register(headerFooterViewType: CustomFooterView.self)
        $0.sameSetting()
    }
    
    //MARK: - Helper
    override func configureUI() {
        super.configureUI()
        //navigationBar
        navigationItem.applyImageNavigation()
        setDelegate()
        //tableView
        mainTableView.refreshControl = refreshControl
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

    //MARK: - Delegate
    private func setDelegate(){
        mainTableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
    }
    //MARK: - bind
    override func bindView(reactor: RefusalReactor) {
        refreshControl.rx.controlEvent(.valueChanged)
            .map(Reactor.Action.refreshDataLoad)
            .delay(.seconds(1), scheduler: MainScheduler.asyncInstance)
            .do(onNext: {[weak self] _ in self?.refreshControl.endRefreshing()})
                .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
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
//MARK: - Refusal Action
extension RefusalViewController : RefusalCancelBtnDelegate{
    func refusalCancelBtnAction(cell: RefusalTableViewCell, id: Int) {
        guard let indexPath = self.mainTableView.indexPath(for: cell) else{ return }
        self.reactor?.action.onNext(.clickRefusalCancelBtn(id, indexPath.row))
    }
}

//MARK: - TableViewHeader & Footer Setting
extension RefusalViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return tableView.dequeueReusableHeaderFooterView(RefusalTableViewHeaderView.self)
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return tableView.dequeueReusableHeaderFooterView(CustomFooterView.self)
    }
}
