//
//  StandByViewController.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/10/18.
//

import UIKit
import Reusable

import RxSwift
import RxCocoa
import RxDataSources

final class StandByViewController : baseVC<StandByReactor>{
    //MARK: - Properties

    private let mainTableView = UITableView(frame: .zero, style: .grouped).then {
        $0.register(headerFooterViewType: StandByTableViewHeaderView.self)
        $0.register(cellType: StandByTableViewCell.self)
        $0.register(headerFooterViewType: CustomFooterView.self)
        $0.sameSetting()
    }

    //MARK: - Helper
    override func configureUI() {
        super.configureUI()
        //navigationItem
        navigationItem.applyImageNavigation()
        setDelegate()
        //tableView
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

    //MARK: - Delegate
    private func setDelegate(){
        mainTableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
    }
    //MARK: - Bind
    override func bindAction(reactor: StandByReactor) {
        self.rx.viewDidLoad
            .map{_ in Reactor.Action.viewDidLoad}
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    override func bindState(reactor: StandByReactor) {
        let dataSource = RxTableViewSectionedReloadDataSource<StandBySection.Model>{ dataSource, tableView, indexPath, sectionItem in
            switch sectionItem{
            case .main(let algorithm):
                let cell = tableView.dequeueReusableCell(for: indexPath) as StandByTableViewCell
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

//MARK: - Click Cell inside Btn Action
extension StandByViewController : StandBytableViewCellBtnClickDelegate{
    func clickSeeMoreDetailBtn(cell: StandByTableViewCell, id: Int, algorithmNumber: Int) {
        guard let indexPath = mainTableView.indexPath(for: cell) else {return}
        _ = reactor?.mutate(action: Reactor.Action.standbyBtnTap(titleText: "선택", message: "게시물을 대기 하시겠습니까?", idx: id, index: indexPath.row,algorithmNumber: algorithmNumber))
    }
}

//MARK: - TableViewHeader & Footer Setting
extension StandByViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return tableView.dequeueReusableHeaderFooterView(StandByTableViewHeaderView.self)
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return tableView.dequeueReusableHeaderFooterView(CustomFooterView.self)
    }
}
