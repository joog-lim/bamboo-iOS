//
//  AcceptViewController.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/10/18.
//

import UIKit
import Reusable

import RxSwift
import RxCocoa
import RxDataSources

final class AcceptViewController : baseVC<AcceptReactor> {
    
    //MARK: - Properties    
    private let titleLabel = UILabel().then{
        $0.font = UIFont(name: "NanumSquareRoundB", size: 20)
        $0.text = "수락"
        $0.textColor = .bamBoo_57CC4D
    }
    
    //MARK: - TableView
    private let mainTableView = UITableView(frame: CGRect.zero, style: .grouped).then {
        $0.register(headerFooterViewType: AcceptTableViewHeaderView.self)
        $0.register(cellType: AcceptManagerTableViewCell.self)
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
    //MARK: - AddView
    override func addView() {
        super.addView()
        view.addSubview(mainTableView)
    }
    
    //MARK: - Location
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
    override func bindAction(reactor: AcceptReactor) {
        self.rx.viewDidLoad
            .map{_ in Reactor.Action.viewDidLoad}
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    override func bindState(reactor: AcceptReactor) {
        let dataSource = RxTableViewSectionedReloadDataSource<AcceptSection.Model>{ dataSource, tableView, indexPath, sectionItem in
            switch sectionItem{
            case .main(let algorithm):
                let cell = tableView.dequeueReusableCell(for: indexPath) as AcceptManagerTableViewCell
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

//MARK: - 수정 버튼 눌렀을때 동작
extension AcceptViewController : AcceptManagerTableViewCellDelegate {
    func cellSettingbtnClick(cell: AcceptManagerTableViewCell, id: Int) {
        guard let indexPath = mainTableView.indexPath(for: cell) else {return}
        reactor?.steps.accept(BambooStep.editContentModalsRequired(idx: id, index: indexPath.row))
    }
}

//MARK: - TableViewHeader & Footer Setting
extension AcceptViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return tableView.dequeueReusableHeaderFooterView(AcceptTableViewHeaderView.self)
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return tableView.dequeueReusableHeaderFooterView(CustomFooterView.self)
    }
}
