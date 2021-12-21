//
//  DeleteViewController.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/10/18.
//

import UIKit

class DeleteViewController : baseVC<DeleteReactor>{
    //MARK: - Properties
    private var isLoaing : Bool = false
    
    var data : [DeleteContent] = [.init(numberOfAlgorithm: 2, data: "2020년 9월 10일", tag: .Employment, title: "This is GSM?", content: "가슴이 웅장해진다.", deleteContente: "가슴이 답답해지는데요"),.init(numberOfAlgorithm: 1, data: "2020년 9월 10일", tag: .Employment, title: "This is GSM?", content: "가슴이 웅장해진다.", deleteContente: "가슴이 답답해지는데요")]
    
    private let titleLabel = UILabel().then{
        $0.font = UIFont(name: "NanumSquareRoundB", size: 20)
        $0.text = "삭제"
        $0.textColor = .red
    }

    private let mainTableView = UITableView().then {
        $0.register(DeleteTableViewCell.self, forCellReuseIdentifier: DeleteTableViewCell.reusableID)
        $0.showsVerticalScrollIndicator = false
        $0.separatorColor = .clear
        $0.allowsSelection = false
    }
    private lazy var tableViewHeader = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: bounds.height/10.15)).then{
        $0.backgroundColor = .clear
    }
    private lazy var tableViewFooter = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: bounds.height/20)).then{
        $0.backgroundColor = .clear
    }
    
    //MARK: - Action
    private func SeeMoreDetailBtnAction(indexPath : Int){
        let actionSheetController  : UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let accessAction : UIAlertAction = UIAlertAction(title: "거절", style: .default) { _ in print("거절")
//            self.RefusalBtnClick(indexPath: indexPath)
        }
        let refusalAction : UIAlertAction = UIAlertAction(title: "삭제", style: .destructive) { _ in
            print("삭제")
        }
        let closeAction : UIAlertAction = UIAlertAction(title: "Close", style: .cancel)
        [accessAction,refusalAction,closeAction].forEach{ actionSheetController.addAction($0)}
        present(actionSheetController, animated: true)
    }
    
    override func configureUI() {
        super.configureUI()
        tableviewSetting()
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

    //MARK: - Data load More
    private func loadMoreData(){
        if !self.isLoaing{
            self.isLoaing = true
            let start = data.count
            let end = data.count + 3
            DispatchQueue.global().async {
                sleep(2)
                for i in start...end{

                    self.data.append(DeleteContent.init(numberOfAlgorithm: i, data: "2021년 11월 20일", tag: .Humor, title: "집에 가자", content: "집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집", deleteContente: "뭐"))
                    
                }
                DispatchQueue.main.async {
                    self.mainTableView.reloadData()
                    self.isLoaing = false
                }
            }
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
    //MARK: - tableViewSetting
    private func tableviewSetting(){
        [mainTableView].forEach { $0.delegate = self ;$0.dataSource = self}
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
    //MARK: - Navigation Setting
    private func navigationSetting(){
        navigationController?.navigationCustomBar()
        navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "square.stack.3d.forward.dottedline.fill"))
        navigationItem.leftBarButtonItem?.tintColor = .bamBoo_57CC4D
        navigationItem.rightBarButtonItem?.tintColor = .rgb(red: 118, green: 177, blue: 87)
        navigationItem.applyImageNavigation()
    }
}
//MARK: - TableView
extension DeleteViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DeleteTableViewCell.reusableID, for: indexPath) as? DeleteTableViewCell else{return UITableViewCell()}
        cell.model = data[ indexPath.item]
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
        if (offsetY > contentHeight - scrollView.frame.height * 3) && !isLoaing{
            loadMoreData()
        }
    }
}

//MARK: - Cell 안에 있는 더보기 버튼 눌렀을때 Action
extension DeleteViewController : cellSeeMoreDetailActionDelegate{
    func clickSeeMoreDetailBtnAction(cell: DeleteTableViewCell) {
        guard let indexPath = self.mainTableView.indexPath(for: cell) else{ return }
        reactor?.steps.accept(BambooStep.alert(titleText: "선택", message: "게시물을 삭제 하시겠습니까?", idx: "\(indexPath.row)",index: indexPath.row))
    }
}
