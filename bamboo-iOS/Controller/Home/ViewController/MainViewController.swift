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
    let data : [Data] = [.init(numberOfAlgorithm: "#193번째 알고리즘", data: "2021년 11월 20일", tag: .School, title: "집에 가자", content: "집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집"),.init(numberOfAlgorithm: "#192번째 알고리즘", data: "2021년 11월 20일", tag: .School, title: "집에 가자", content: "집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집"),.init(numberOfAlgorithm: "#191번째 알고리즘", data: "2021년 11월 20일", tag: .School, title: "집에 가자", content: "집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집")]
    
    private lazy var tableViewHeader = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: bounds.height/10.15)).then{
        $0.backgroundColor = .clear
    }
    
    //MARK: - 모달 background 설정
    let bgView = UIView().then {
        $0.backgroundColor = .black
        $0.alpha = 0
    }
    
    private let titleLabel = UILabel().then{
        let string : NSMutableAttributedString = NSMutableAttributedString(string: "하고 싶던 말,\n무엇인가요?")
        $0.dynamicFont(fontSize: 20, currentFontName: "NanumSquareRoundB")
        $0.textColor = .rgb(red: 87, green: 204, blue: 77)
        $0.numberOfLines = 2
        string.setColorForText(textToFind: "무엇인가요?", withColor: .black)
        $0.attributedText = string
    }

    private let mainTableView : UITableView = {
        let tv = UITableView()
        tv.register(BulletinBoardsTableViewCell.self, forCellReuseIdentifier: BulletinBoardsTableViewCell.identifier)
        tv.showsVerticalScrollIndicator = false
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = .clear
        tv.separatorColor = .clear
        tv.allowsSelection = false
        tv.estimatedRowHeight = 300
        tv.rowHeight = UITableView.automaticDimension
        return tv
    }()
    
    private lazy var writeBtn = UIButton(type: .system).then{
        $0.backgroundColor = .bamBoo_57CC4D
        $0.setImage(UIImage(named: "BAMBOO_Pencil")?.withRenderingMode(.alwaysTemplate), for: .normal)
        $0.addTarget( self, action: #selector(writeBtnClick), for: .touchUpInside)
        $0.tintColor = .white
        $0.layer.applySketchShadow(color: .bamBoo_57CC4D, alpha: 0.25, x: 1, y: 5, blur: 5, spread: 0)
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        mainTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: bounds.height/22, right: 0)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI()
        mainTableView.selectRow(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .top)
    }
    
    //MARK: - Selectors
    @objc private func writeBtnClick(){
        let WritingBulletinBoardModalModalsVC = WritingBulletinBoardModal.instance()
        WritingBulletinBoardModalModalsVC.delegate = self
        addDim()
        present(WritingBulletinBoardModalModalsVC, animated: true, completion: nil)
    }
    //MARK: - 모달 위치
    static func instance() -> MainViewController{
        MainViewController(nibName: nil, bundle: nil)
    }
    //모달 실행시 Action
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
    //모달 취소시 Action
    private func removeDim() {
        DispatchQueue.main.async { [weak self] in
            self?.bgView.removeFromSuperview()
            self?.navigationController?.navigationBar.backgroundColor = .clear
        }
    }
    //MARK: - Helper
    private func configureUI(){
        addView()
        location()
        tableviewSetting()
        tableViewHeaderSetting()
        cornerRadius()
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
        mainTableView.dataSource = self
        mainTableView.delegate = self
        mainTableView.estimatedRowHeight = 200
        mainTableView.rowHeight = UITableView.automaticDimension
    }
    //MARK: - AddView
    private func addView(){
        view.addSubview(mainTableView)
        view.addSubview(writeBtn)
    }
    //MARK: - Location
    private func location(){
        mainTableView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.left.right.equalToSuperview()
        }
        writeBtn.snp.makeConstraints {
            $0.height.width.equalTo(bounds.height/13.53)
            $0.right.bottom.equalToSuperview().inset(bounds.height/40.6)
        }
    }
    private func cornerRadius(){
        writeBtn.layer.cornerRadius = bounds.height/27
    }
    
}

//MARK: - TableView
extension MainViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BulletinBoardsTableViewCell.identifier, for: indexPath) as? BulletinBoardsTableViewCell else{return UITableViewCell()}
        cell.model = data[indexPath.row]
        return cell
    }
}

extension MainViewController : WriteModalDelegate {
    func onTapClose() {
        self.removeDim()
    }
}
