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
    private let mainTableView = UITableView(frame: .zero, style: .grouped).then {
        $0.register(headerFooterViewType: DeleteTableViewHeaderView.self)
        $0.register(cellType: DeleteTableViewCell.self)
        $0.register(headerFooterViewType: CustomFooterView.self)
        $0.sameSetting()
    }
    
    //MARK: - Helper
    override func configureUI() {
        super.configureUI()
        navigationItem.applyImageNavigation()
        setDelegate()
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
    override func bindAction(reactor: DeleteReactor) {
        self.rx.viewDidLoad
            .map{ _ in Reactor.Action.viewDidLoad}
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    override func bindState(reactor: DeleteReactor) {
        let dataSource = RxTableViewSectionedReloadDataSource<DeleteSection.Model>{ dataSource,tableView,indexPath,sectionItem in
            switch sectionItem{
            case .main(let algorithm):
                let cell = tableView.dequeueReusableCell(for: indexPath) as DeleteTableViewCell
                cell.model = algorithm
                cell.delegate = self
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

//MARK: - Cell 안에 있는 더보기 버튼 눌렀을때 Action
extension DeleteViewController : cellSeeMoreDetailActionDelegate{
    func clickSeeMoreDetailBtnAction(cell: DeleteTableViewCell, id: Int) {
        guard let indexPath = self.mainTableView.indexPath(for: cell) else{ return }
        mainTableView.reloadData()
        _ = reactor?.mutate(action: DeleteReactor.Action.deleteBtnTap(titleText: "선택", message: "게시물을 삭제 하시겠습니까?", idx: id, index: indexPath.row))
    }
}

//MARK: - TableViewHeader & Footer Setting
extension DeleteViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return tableView.dequeueReusableHeaderFooterView(DeleteTableViewHeaderView.self)
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return tableView.dequeueReusableHeaderFooterView(CustomFooterView.self)
    }
}
