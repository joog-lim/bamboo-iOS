//
//  MainViewController.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/09/13.
//

import UIKit
import RxDataSources

class MainViewController : baseVC<MainReactor>{
    
    //MARK: - Properties
    private var isLoaing : Bool = false
    
    lazy var data : [Data] = [.init(numberOfAlgorithm: 1, data: "2021년 11월 20일", tag: .DailyRoutine, title: "집에 가자", content: "집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집", like: 3, isSelected: false),.init(numberOfAlgorithm: 1, data: "2021년 11월 20일", tag: .DailyRoutine, title: "집에 가자", content: "집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집", like: 3, isSelected: false)]
    
    
    private let titleLabel = UILabel().then{
        let string : NSMutableAttributedString = NSMutableAttributedString(string: "하고 싶던 말,\n무엇인가요?")
        $0.font = UIFont(name: "NanumSquareRoundB", size: 20)
        $0.textColor = .bamBoo_57CC4D
        $0.numberOfLines = 2
        string.setColorForText(textToFind: "무엇인가요?", withColor: .black)
        $0.attributedText = string
    }

    private let mainTableView = UITableView().then {
        $0.register(BulletinBoardsTableViewCell.self, forCellReuseIdentifier: BulletinBoardsTableViewCell.identifier)
        $0.showsVerticalScrollIndicator = false
        $0.separatorColor = .clear
        $0.allowsSelection = false
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
        data[indexPath].isSelected = state
    }
    
    //MARK: - Helper
    override func configureUI() {
        super.configureUI()
        tableviewSetting()
        tableViewHeaderSetting()
        navigationSetting()
        tableFooterViewSetting()
        mainTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: bounds.height/22, right: 0)
    }
    override func addView() {
        super.addView()
        [mainTableView,writeBtn].forEach{view.addSubview($0)}
    }
    override func setLayout() {
        super.setLayout()
        mainTableView.snp.makeConstraints { (make) in
            make.top.bottom.left.right.equalToSuperview()
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
    //MARK: - tableViewSetting
    private func tableviewSetting(){
        [mainTableView].forEach { $0.delegate = self ;$0.dataSource = self}
    }
    //MARK: - Header
    private func tableViewHeaderSetting(){
        mainTableView.tableHeaderView = tableViewHeader
        mainTableView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.left.equalToSuperview().offset(20)
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
    //MARK: - Navigation Setting
    private func navigationSetting(){
        navigationController?.navigationCustomBar()
        navigationItem.applyImageNavigation()
    }
    
    //MARK: - Data load More
    private func loadMoreData(){
        if !self.isLoaing{
            self.isLoaing = true
            let start = data.count
            let end = data.count + 3
            DispatchQueue.global().async {
                sleep(2)
                for i in start...end{
                    self.data.append(Data.init(numberOfAlgorithm: i, data: "2021년 11월 20일", tag: .Humor, title: "집에 가자", content: "집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집",like: 3))
                }
                DispatchQueue.main.async {
                    self.mainTableView.reloadData()
                    self.isLoaing = false
                }
            }
        }
    }
    override func bindView(reactor: MainReactor) {
        super.bindView(reactor: reactor)
        writeBtn.rx.tap
            .map{Reactor.Action.writeData}
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
}

//MARK: - TableView
extension MainViewController: UITableViewDelegate, UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: BulletinBoardsTableViewCell.identifier, for: indexPath) as? BulletinBoardsTableViewCell else{return UITableViewCell()}
            cell.model = data[indexPath.item]
            cell.delegate = self
            return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if (offsetY > contentHeight - scrollView.frame.height * 4) && !isLoaing{
            loadMoreData()
        }
    }
}


//MARK: - Write Modal Delegate
extension MainViewController : WriteModalDelegate {
    func updateWrite() {
    
    }
}

//MARK: - Report Modal Update Function
extension MainViewController : ReportModalDelegate{
    func updateReport() {
        
    }
}
extension MainViewController : BaseModalDelegate{
    func onTapClick() {
//        self.removeDim()
    }
}

//MARK: - tableView Cell inside ReportBtn Click Action Protocol
extension MainViewController : ClickReportBtnActionDelegate{
    func clickLikeBtnAction(cell: BulletinBoardsTableViewCell, state: Bool) {
        guard let indexPath = self.mainTableView.indexPath(for: cell) else {return}
        self.likeBtnClick(indexPath: indexPath.item, state: state)
    }
    
    func clickReportBtnAction(cell: BulletinBoardsTableViewCell) {
        guard let indexPath = self.mainTableView.indexPath(for: cell) else{ return }
        print(indexPath.row)
//        self.reportBtnClick(indexPath: indexPath.item)
    }
}
