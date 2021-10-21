//
//  DeleteViewController.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/10/18.
//

import UIKit

class DeleteViewController : BaseVC{
    //MARK: - Properties
    private var isLoaing : Bool = false
    
    var data : [DeleteContent] = [.init(numberOfAlgorithm: 2, data: "2020년 9월 10일", tag: .Employment, title: "This is GSM?", content: "가슴이 웅장해진다.", deleteContente: "가슴이 답답해지는데요"),.init(numberOfAlgorithm: 1, data: "2020년 9월 10일", tag: .Employment, title: "This is GSM?", content: "가슴이 웅장해진다.", deleteContente: "가슴이 답답해지는데요")]
    
    private lazy var tableViewHeader = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: bounds.height/10.15)).then{
        $0.backgroundColor = .clear
    }
    private lazy var tableViewFooter = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: bounds.height/20)).then{
        $0.backgroundColor = .clear
    }
    
    
    private let titleLabel = UILabel().then{
        $0.dynamicFont(fontSize: 20, currentFontName: "NanumSquareRoundB")
        $0.text = "삭제"
        $0.textColor = .red
    }

    private let mainTableView = UITableView().then {
        $0.register(DeleteTableViewCell.self, forCellReuseIdentifier: DeleteTableViewCell.identifier)
        $0.register(UITableViewCell.self, forCellReuseIdentifier: "cellSpace")
        $0.showsVerticalScrollIndicator = false
        $0.separatorColor = .clear
        $0.allowsSelection = false
    }
    
    //MARK: - Selectors


    //MARK: - Helper
    override func configure() {
        super.configure()
        mainTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: bounds.height/4.06, right: 0)
    }
    override func configureAppear() {
        super.configureAppear()
        addView()
        location()
        tableviewSetting()
        tableViewHeaderSetting()
        tableFooterViewSetting()
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
}

//MARK: - TableView
extension DeleteViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.item == 0{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DeleteTableViewCell.identifier, for: indexPath) as? DeleteTableViewCell else{return UITableViewCell()}
            cell.model = data[ indexPath.section]
            return cell
        }else if indexPath.item == 1{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellSpace") else {return UITableViewCell()}
            cell.backgroundColor = .clear
            return cell
        }
        return UITableViewCell()

    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.item == 0{
            return UITableView.automaticDimension
        }
        else if indexPath.item == 1{
            return bounds.height/81.2
        }
        return 0
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

