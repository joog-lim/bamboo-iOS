//
//  RefusalViewController.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/10/18.
//

import UIKit

class RefusalViewController : BaseVC{
    //MARK: - Properties
    private var isLoaing : Bool = false
    
    var data : [Data] = [.init(numberOfAlgorithm: 193, data: "2021년 11월 20일", tag: .School, title: "집에 가자", content: "집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집"),.init(numberOfAlgorithm: 192, data: "2021년 11월 20일", tag: .School, title: "집에 가자", content: "집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집"),.init(numberOfAlgorithm: 191, data: "2021년 11월 20일", tag: .School, title: "집에 가자", content: "집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집")]
    
    private lazy var tableViewHeader = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: bounds.height/10.15)).then{
        $0.backgroundColor = .clear
    }
    
    
    private let titleLabel = UILabel().then{
        let string : NSMutableAttributedString = NSMutableAttributedString(string: "안녕하세요,\n관리자님!")
        $0.dynamicFont(fontSize: 20, currentFontName: "NanumSquareRoundB")
        $0.textColor = .rgb(red: 87, green: 204, blue: 77)
        $0.numberOfLines = 2
        string.setColorForText(textToFind: "관리자님!", withColor: .black)
        $0.attributedText = string
    }

    private let mainTableView = UITableView().then {
        $0.register(BulletinBoardsTableViewCell.self, forCellReuseIdentifier: BulletinBoardsTableViewCell.identifier)
        $0.register(TableViewLoadingCell.self, forCellReuseIdentifier: TableViewLoadingCell.identifier)
        $0.showsVerticalScrollIndicator = false
        $0.separatorColor = .clear
        $0.allowsSelection = false
        $0.estimatedRowHeight = 300
    }
    
    //MARK: - Selectors


    //MARK: - Helper
    override func configure() {
        super.configure()
        mainTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: bounds.height/22, right: 0)
    }
    override func configureAppear() {
        super.configureAppear()
        addView()
        location()
        tableviewSetting()
        tableViewHeaderSetting()
        mainTableView.selectRow(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .top)
    }
    //MARK: - AddView
    private func addView(){
        view.addSubview(mainTableView)
    }
    
    //MARK: - Location
    private func location(){
        mainTableView.snp.makeConstraints { (make) in
            make.top.bottom.left.right.equalToSuperview()
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
                    if i < 0{
                        TableViewLoadingCell().noAlgorithm.isHidden = false
                        TableViewLoadingCell().activityIndicatorView.isHidden = true
                    }else{
                        self.data.append(Data.init(numberOfAlgorithm: i, data: "2021년 11월 20일", tag: .Humor, title: "집에 가자", content: "집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집"))
                    }
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
            $0.top.equalToSuperview().offset(bounds.height/40.6)
            $0.left.equalToSuperview().offset(bounds.width/18.75)
        }
    }
    //MARK: - tableViewSetting
    private func tableviewSetting(){
        [mainTableView].forEach { $0.delegate = self ;$0.dataSource = self}
    }
}

//MARK: - TableView
extension RefusalViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return data.count
        }else if section == 1 {
            return 1
        }else{
            return 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: BulletinBoardsTableViewCell.identifier, for: indexPath) as? BulletinBoardsTableViewCell else{return UITableViewCell()}
            cell.model = data[indexPath.row]
            return cell
        }else{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewLoadingCell.identifier, for: indexPath) as? TableViewLoadingCell else { return UITableViewCell()}
            cell.activityIndicatorView.startAnimating()
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return UITableView.automaticDimension
        }else{
            return 50
        }
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if (offsetY > contentHeight - scrollView.frame.height * 4) && !isLoaing{
            loadMoreData()
        }
    }
}


