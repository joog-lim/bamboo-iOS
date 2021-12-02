//
//  AcceptViewController.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/10/18.
//

import UIKit

class AcceptViewController : BaseVC {
    
    //MARK: - Properties
    private var isLoaing : Bool = false
    
    //MARK: - 모달 background 설정
    private let bgView = UIView().then {
        $0.backgroundColor = .black
        $0.alpha = 0
    }
    //MARK: - dummyData
    var data : [ManagerTextData] = [.init(numberOfAlgorithm: 193, data: "2021년 11월 20일", tag: .School, title: "집에 가자", content: "집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집"),.init(numberOfAlgorithm: 192, data: "2021년 11월 20일", tag: .School, title: "집에 가자", content: "집"),.init(numberOfAlgorithm: 191, data: "2021년 11월 20일", tag: .School, title: "집에 가자", content: "집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집")]
    
    private let titleLabel = UILabel().then{
        $0.font = UIFont(name: "NanumSquareRoundB", size: 20)
        $0.text = "수락"
        $0.textColor = .bamBoo_57CC4D
    }
    
    //MARK: - TableView
    private let mainTableView = UITableView().then {
        $0.register(AcceptManagerTableViewCell.self, forCellReuseIdentifier: AcceptManagerTableViewCell.identifier)
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
    

    //MARK: - Helper
    override func configureAppear() {
        super.configureAppear()
        addView()
        location()
        tableviewSetting()
        tableViewHeaderSetting()
        tableFooterViewSetting()
        mainTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 0)
        mainTableView.selectRow(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .top)
    }
    //MARK: - AddView
    private func addView(){
        view.addSubview(mainTableView)
    }
    
    //MARK: - Location
    private func location(){
        mainTableView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.left.right.equalToSuperview()
        }
    }
    
    //MARK: - Modal action
    //MARK: - tableView Cell 안에 있는 버튼 눌렸을때 동작
    private func EditBtnClick(indexPath : Int){
        print("수락 : \(indexPath)")
        AcceptModal(index: indexPath)
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
                    self.data.append(ManagerTextData.init(numberOfAlgorithm: i, data: "2021년 11월 20일", tag: .Humor, title: "집에 가자", content: "집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집"))
                }
                DispatchQueue.main.async {
                    self.mainTableView.reloadData()
                    self.isLoaing = false
                }
            }
        }
    }

    //MARK: - Header Setting
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
    //MARK: - Footer Setting
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
}

//MARK: - TableView
extension AcceptViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AcceptManagerTableViewCell.identifier, for: indexPath) as? AcceptManagerTableViewCell else{return UITableViewCell()}
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
        if (offsetY > contentHeight - scrollView.frame.height * 4) && !isLoaing{
            loadMoreData()
        }
    }
}

//MARK: - 수정 버튼 눌렀을때 동작
extension AcceptViewController : AcceptManagerTableViewCellDelegate {
    func cellSettingbtnClick(cell: AcceptManagerTableViewCell) {
        guard let indexPath = mainTableView.indexPath(for: cell) else {return}
        self.EditBtnClick(indexPath: indexPath.item)
    }
}

extension AcceptViewController {
    //MARK: - 모달 실행시 Action
    private func addDim() {
        view.addSubview(bgView)
        bgView.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalToSuperview()
        }
        DispatchQueue.main.async { [weak self] in
            self?.bgView.alpha = 0.1
            self?.navigationController?.navigationBar.backgroundColor = self?.bgView.backgroundColor?.withAlphaComponent(0.1)
        }
    }
    //MARK: - 모달 닫기
    private func removeDim() {
        DispatchQueue.main.async { [weak self] in
            self?.bgView.removeFromSuperview()
            self?.navigationController?.navigationBar.backgroundColor = .clear
        }
    }
}

extension AcceptViewController : BaseModalDelegate{
    func onTapClick() {
        self.removeDim()
    }
}

extension AcceptViewController{
        private func AcceptModal(index: Int){
            let EditContentModalModalsVC = EditContentModal.instance()
            EditContentModalModalsVC.delegate = self
            EditContentModalModalsVC.baseDelegate = self
            addDim()
            present(EditContentModalModalsVC, animated: true, completion: nil)
        }
}

extension AcceptViewController: EditContentModalProtocol{
    func onTapClose() {
        removeDim()
    }
}
