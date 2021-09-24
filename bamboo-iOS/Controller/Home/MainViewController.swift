//
//  MainViewController.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/09/13.
//

import UIKit

class MainViewController : UIViewController{
    
    //MARK: - Properties
    private let bounds = UIScreen.main.bounds
    
    private lazy var tableViewHeader = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: bounds.height/10.15)).then{
        $0.backgroundColor = .clear
    }
    
    private let titleLabel = UILabel().then{
        let string : NSMutableAttributedString = NSMutableAttributedString(string: "하고 싶던 말,\n무엇인가요?")
        $0.dynamicFont(fontSize: 20, currentFontName: "NanumSquareRoundB")
        $0.textColor = .rgb(red: 87, green: 204, blue: 77)
        $0.numberOfLines = 2
        string.setColorForText(textToFind: "무엇인가요?", withColor: .black)
        $0.attributedText = string
        
    }

    fileprivate let mainTableView : UITableView = {
        let tv = UITableView()
        tv.register(BulletinBoardTableVIewCell.self, forCellReuseIdentifier: BulletinBoardTableVIewCell.identifier)
        tv.showsVerticalScrollIndicator = false
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = .clear
        tv.separatorColor = .clear
        tv.allowsSelection = false
        tv.rowHeight = 300
        tv.estimatedRowHeight = 300
        tv.rowHeight = UITableView.automaticDimension
        return tv
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    
    //MARK: - Helper
    func configureUI(){
        addView()
        location()
        tableviewSetting()
        tableViewHeaderSetting()
    }
    //MARK: - NavigationBar Setting

    //MARK: - TableViewHeaderSetting
    func tableViewHeaderSetting(){
        mainTableView.tableHeaderView = tableViewHeader
        mainTableView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(bounds.height/40.6)
            $0.left.equalToSuperview().offset(bounds.width/18.75)
        }
       
    }
    //MARK: - tableViewSetting
    func tableviewSetting(){
        mainTableView.dataSource = self
        mainTableView.delegate = self
        mainTableView.estimatedRowHeight = 200
        mainTableView.rowHeight = UITableView.automaticDimension
    }
    //MARK: - AddView
    func addView(){
        view.addSubview(mainTableView)
    }
    //MARK: - Location
    func location(){
        mainTableView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.left.right.equalToSuperview()
        }

    }
}
//MARK: - TableView
extension MainViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BulletinBoardTableVIewCell.identifier, for: indexPath) as? BulletinBoardTableVIewCell else{return UITableViewCell()}
        
        return cell
    }
    
    
    
}
