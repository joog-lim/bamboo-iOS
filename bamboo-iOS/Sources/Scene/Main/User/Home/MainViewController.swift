import UIKit
import Reusable
import RxSwift
import RxCocoa
import RxDataSources

final class MainViewController : baseVC<MainReactor>{
    
    //MARK: - Properties
    private var isLoaing : Bool = false
    
    private let titleLabel = UILabel().then{
        let string : NSMutableAttributedString = NSMutableAttributedString(string: "하고 싶던 말,\n무엇인가요?")
        $0.font = UIFont(name: "NanumSquareRoundB", size: 20)
        $0.textColor = .bamBoo_57CC4D
        $0.numberOfLines = 2
        string.setColorForText(textToFind: "무엇인가요?", withColor: .black)
        $0.attributedText = string
    }

    private let mainTableView = UITableView(frame: .zero).then {
        $0.register(cellType: BulletinBoardsTableViewCell.self)
        $0.register(headerFooterViewType: CustomFooterView.self)
        $0.separatorColor = .clear
        $0.showsVerticalScrollIndicator = false
        $0.allowsSelection = false
        $0.rowHeight = UITableView.automaticDimension
        $0.sectionHeaderHeight = 152
        $0.estimatedRowHeight = 300
    }
    
    private lazy var tableViewHeader = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 80))
    private lazy var tableViewFooter = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: bounds.height/20))
    
    private let writeBtn = UIButton(type: .system).then{
        $0.backgroundColor = .bamBoo_57CC4D
        $0.imageView?.contentMode = .scaleAspectFit
        $0.setImage(UIImage(named: "BAMBOO_Pencil")?.withRenderingMode(.alwaysTemplate), for: .normal)
        $0.tintColor = .white
        $0.layer.applySketchShadow(color: .bamBoo_57CC4D, alpha: 0.25, x: 1, y: 5, blur: 5, spread: 0)
    }

    private func likeBtnClick(indexPath : Int, state : Bool){
        print("좋아요 :: \(indexPath)번째 \(state)")
        //        data[indexPath].isSelected = state
    }

    //MARK: - Helper
    override func configureUI() {
        super.configureUI()
        navigationItem.applyImageNavigation()

        tableViewHeaderSetting()
        tableFooterViewSetting()
        mainTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: bounds.height/22, right: 0)
    }
    //MARK: - addView
    override func addView() {
        super.addView()
        view.addSubviews(mainTableView,writeBtn)
    }
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
    
    //MARK: - Header
    private func tableViewHeaderSetting(){
        mainTableView.tableHeaderView = tableViewHeader
        mainTableView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.left.equalToSuperview().offset(20)
        }
    }
    //MARK: - Footer
    private func tableFooterViewSetting(){
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.startAnimating()
        mainTableView.tableFooterView = tableViewFooter
        mainTableView.addSubview(activityIndicatorView)
        activityIndicatorView.snp.makeConstraints { make in
            make.center.equalTo(tableViewFooter)
        }
    }
    
    //MARK: -  Bind
    override func bindView(reactor: MainReactor) {
        writeBtn.rx.tap
            .map{Reactor.Action.writeData}
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    override func bindAction(reactor: MainReactor) {
        self.rx.viewDidLoad
            .map{_ in Reactor.Action.viewDidLoad}
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
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
        reactor?.steps.accept(BambooStep.reportModalsRequired(idx: id, index: indexPath.row))
    }
    
    func clickLikeBtnAction(cell: BulletinBoardsTableViewCell,  id: Int, state: Bool) {
        guard let indexPath = self.mainTableView.indexPath(for: cell) else {return}
        self.likeBtnClick(indexPath: indexPath.item, state: state)
        _ = reactor?.mutate(action: Reactor.Action.emojiBtnClick(idx: id))
    }
}
