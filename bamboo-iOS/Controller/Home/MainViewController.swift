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
    let i = 100
    let data = ["집집집집집집집집집","집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집","집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집","집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집","집집집집집집집집집집집집집집집집집집","집집집집집집집집집","집집집집집집집집집","집집집집집집집집집집집집집집집집집집집집집집집집집집집","집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집집","집집집집집집집집집"]
    
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

    fileprivate let mainCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .vertical
        
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(BulletinBoardCollectionViewCell.self, forCellWithReuseIdentifier: BulletinBoardCollectionViewCell.identifier)
        cv.backgroundColor = .clear
        cv.showsVerticalScrollIndicator = false
        cv.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        return cv
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
        collectionViewSetting()
//        tableViewHeaderSetting()
    }
    //MARK: - NavigationBar Setting

    //MARK: - TableViewHeaderSetting
//    func tableViewHeaderSetting(){
//        mainCollectionView.collectionViewHeder = tableViewHeader
//        mainCollectionView.addSubview(titleLabel)
//        titleLabel.snp.makeConstraints {
//            $0.top.equalToSuperview().offset(bounds.height/40.6)
//            $0.left.equalToSuperview().offset(bounds.width/18.75)
//        }
//
//    }
    //MARK: - CollectionViewViewSetting
    func collectionViewSetting(){
        mainCollectionView.dataSource = self
        mainCollectionView.delegate = self
    }
    //MARK: - AddView
    func addView(){
        view.addSubview(mainCollectionView)
    }
    //MARK: - Location
    func location(){
        mainCollectionView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.left.right.equalToSuperview()
        }
    }
}
extension MainViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BulletinBoardCollectionViewCell.identifier, for: indexPath) as? BulletinBoardCollectionViewCell else {return UICollectionViewCell()}
        
        return cell
    }

    
}
extension MainViewController : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width/1.12, height: 100)
    }
}
extension MainViewController : UICollectionViewDelegateFlowLayout{
    
}
