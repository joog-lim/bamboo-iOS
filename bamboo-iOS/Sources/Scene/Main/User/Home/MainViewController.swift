import UIKit
import Reusable
import RxSwift
import RxCocoa
import RxDataSources

final class MainViewController : baseVC<MainReactor>{
    //MARK: - Properties
    private let mainTableView = UITableView(frame: CGRect.zero, style: .grouped).then {
        $0.register(headerFooterViewType: BulletinBoardsTableViewHeaderView.self)
        $0.register(cellType: BulletinBoardsTableViewCell.self)
        $0.register(headerFooterViewType: CustomFooterView.self)
        $0.sameSetting()
    }
        
    private let writeBtn = UIButton(type: .system).then{
        $0.backgroundColor = .bamBoo_57CC4D
        $0.imageView?.contentMode = .scaleAspectFit
        $0.setImage(UIImage(named: "BAMBOO_Pencil")?.withRenderingMode(.alwaysTemplate), for: .normal)
        $0.tintColor = .white
        $0.layer.applySketchShadow(color: .bamBoo_57CC4D, alpha: 0.25, x: 1, y: 5, blur: 5, spread: 0)
    }

    private func likeBtnClick(indexPath : Int, state : Bool){
        print("좋아요 :: \(indexPath)번째 \(state)")
    }

    //MARK: - Helper
    override func configureUI() {
        super.configureUI()
        navigationItem.applyImageNavigation()
        setDelegate()
        mainTableView.refreshControl = UIRefreshControl()
        mainTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: bounds.height/22, right: 0)
    }
    
    //MARK: - addView
    override func addView() {
        super.addView()
        view.addSubviews(mainTableView,writeBtn)
    }
    
    //MARK: - layout
    override func setLayout() {
        super.setLayout()
        mainTableView.snp.makeConstraints { (make) in
            make.edges.equalTo(view.safeArea.edges)
        }
        writeBtn.snp.makeConstraints {
            $0.height.width.equalTo(bounds.height/13.53)
            $0.right.bottom.equalTo(view.safeAreaLayoutGuide).inset(bounds.height/40.6)
        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        writeBtn.layer.cornerRadius = writeBtn.frame.height/2
    }
    //MARK: - Delegate
    private func setDelegate(){
        mainTableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
    }
    
    //MARK: -  Bind
    // - UI
    override func bindView(reactor: MainReactor) {
        writeBtn.rx.tap
            .map{Reactor.Action.writeData}
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    // - Action
    override func bindAction(reactor: MainReactor) {
        self.rx.viewDidLoad
            .map{_ in Reactor.Action.viewDidLoad}
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    // - State
    override func bindState(reactor: MainReactor) {
        let dataSource = RxTableViewSectionedReloadDataSource<MainSection.Model>{ dataSource, tableView, indexPath, sectionItem in
            switch sectionItem{
            case.main(let algorithm):
                let cell = tableView.dequeueReusableCell(for: indexPath) as BulletinBoardsTableViewCell
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
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state.map(\.mainSection)
            .distinctUntilChanged()
            .map(Array.init(with:))
            .bind(to: self.mainTableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
}
//MARK: - tableView Cell inside ReportBtn Click Action Protocol
extension MainViewController : ClickReportBtnActionDelegate{
    func clickReportBtnAction(cell: BulletinBoardsTableViewCell, id: Int) {
        guard let indexPath = self.mainTableView.indexPath(for: cell) else{ return }
        _ = reactor?.mutate(action: Reactor.Action.reportBtnClickAction(idx: id, index: indexPath.row))
    }
    
    func clickLikeBtnAction(cell: BulletinBoardsTableViewCell,  id: Int, state: Bool) {
        guard let indexPath = self.mainTableView.indexPath(for: cell) else {return}
        self.likeBtnClick(indexPath: indexPath.row, state: state)
         reactor?.action.onNext(.emojiBtnClick(idx: id, indexPath: indexPath.row, state: state))
    }
}

//MARK: - TableViewHeader & Footer Setting
extension MainViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return tableView.dequeueReusableHeaderFooterView(BulletinBoardsTableViewHeaderView.self)
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return tableView.dequeueReusableHeaderFooterView(CustomFooterView.self)
    }
}



