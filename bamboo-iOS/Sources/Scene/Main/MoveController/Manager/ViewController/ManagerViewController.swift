//
//  ManagerViewController.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/10/05.
//

import UIKit

class ManagerViewController: BaseVC{
    //MARK: - Properties
    private var isLoaing : Bool = false
    let chooseDropDown : [ManagerData.status] = [.Accept,.StandBy,.Refusal,.Delete]
    var data : [Data] = [.init(numberOfAlgorithm: 193, data: "2021년 11월 20일", tag: .School, title: "집에 가자", content: "집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집"),.init(numberOfAlgorithm: 192, data: "2021년 11월 20일", tag: .School, title: "집에 가자", content: "집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집"),.init(numberOfAlgorithm: 191, data: "2021년 11월 20일", tag: .School, title: "집에 가자", content: "집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집"),.init(numberOfAlgorithm: 191, data: "2021년 11월 20일", tag: .School, title: "집에 가자", content: "집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집"),.init(numberOfAlgorithm: 191, data: "2021년 11월 20일", tag: .School, title: "집에 가자", content: "집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집")]
    
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
    private let userBtn = UIButton().then{
        $0.setTitle("사용자", for: .normal)
        $0.dynamicFont(fontSize: 9, currentFontName: "NanumSquareRoundB")
        $0.setTitleColor(.lightGray, for: .normal)
        $0.addTarget(self, action: #selector(ChangeUserPage), for: .touchUpInside)
    }
    private let selectedPageBtn = CustomDropDownBtn(placeholder: "수락").then{
        $0.backgroundColor = .white
        $0.layer.applySketchShadow(color: .black, alpha: 0.1, x: 0, y: 1, blur: 4, spread: 0)
        $0.layer.cornerRadius = 5
    }
    private let mainTableView : UITableView = {
        let tv = UITableView()
        tv.register(AcceptManagerTableViewCell.self, forCellReuseIdentifier: AcceptManagerTableViewCell.identifier)
        tv.register(TableViewLoadingCell.self, forCellReuseIdentifier: TableViewLoadingCell.identifier)
        tv.showsVerticalScrollIndicator = false
        tv.separatorColor = .clear
        tv.allowsSelection = false
        return tv
    }()
    
    private let dropdownTv = UITableView().then{
        $0.showsVerticalScrollIndicator = false
        $0.register(ManagerStatusDropDownTableViewCell.self, forCellReuseIdentifier: ManagerStatusDropDownTableViewCell.identifier)
        $0.separatorColor = .clear
        $0.allowsSelection = false
    }
    
    //MARK: - Selectors
 
    @objc func ChangeUserPage(){
        navigationController?.pushViewController(MainViewController(), animated: true)
    }
    //MARK: - Helpers
    
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
        mainTableView.addSubview(userBtn)
        mainTableView.addSubview(dropdownTv)
        mainTableView.addSubview(selectedPageBtn)
        dropdownTv.layer.borderColor = UIColor.lightGray.cgColor
        dropdownTv.layer.borderWidth = 0.3
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(bounds.height/40.6)
            $0.left.equalToSuperview().offset(bounds.width/18.75)
        }
        userBtn.snp.makeConstraints {
            $0.centerY.equalTo(tableViewHeader)
            $0.width.equalTo(bounds.width/7.5)
            $0.height.equalTo(bounds.height/40.6)
            $0.right.equalTo(selectedPageBtn.snp.left)
        }
        selectedPageBtn.snp.makeConstraints {
            $0.centerY.equalTo(tableViewHeader)
            $0.width.equalTo(bounds.width/5.734)
            $0.height.equalTo(bounds.height/38.66)
            $0.right.equalTo(tableViewHeader).inset(bounds.width/18.2038)
        }
        dropdownTv.snp.makeConstraints {
            $0.right.equalTo(tableViewHeader).inset(bounds.width/18.203)
            $0.centerY.equalTo(tableViewHeader)
            $0.width.equalTo(bounds.width/5.734)
            $0.height.equalTo(bounds.height/38.66  * CGFloat(chooseDropDown.count))
        }
        dropdownTv.isHidden = true
    }
    
    //MARK: - tableViewSetting
    private func tableviewSetting(){
        dropdownTv.delegate = self
        [mainTableView,dropdownTv].forEach { $0.dataSource = self}
        mainTableView.estimatedRowHeight = 200
    }

}

//MARK: - Extension
extension ManagerViewController : UITableViewDataSource,UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == mainTableView{
            return 2
        }else if tableView == dropdownTv{
            return 1
        }
        else{
            return 0
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == mainTableView{
            if section == 0{
                return data.count
            }else if section == 1 {
                return 1
            }else{
                return 0
            }
        }else{
            return chooseDropDown.count
        }
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == mainTableView{
            if indexPath.section == 0 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: AcceptManagerTableViewCell.identifier, for: indexPath) as? AcceptManagerTableViewCell else{return UITableViewCell()}
                cell.model = data[indexPath.row]
                return cell
            }else{
                guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewLoadingCell.identifier, for: indexPath) as? TableViewLoadingCell else { return UITableViewCell()}
                cell.activityIndicatorView.startAnimating()
                return cell
            }
        }else{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ManagerStatusDropDownTableViewCell.identifier ,for: indexPath) as? ManagerStatusDropDownTableViewCell else {return UITableViewCell()}
            cell.model = chooseDropDown[indexPath.row]
            return cell
        }
       
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == mainTableView{
            if indexPath.section == 0 {
                return UITableView.automaticDimension
            }else{
                return bounds.height/16.24
            }
        }else{
            return bounds.height/38.66
        }
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if (offsetY > contentHeight - scrollView.frame.height * 2) && !isLoaing{
            loadMoreData()
        }
    }
}
