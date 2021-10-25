//
//  CustomMenuBar.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/10/18.
//

import UIKit

protocol CustomMenuBarDelegate: AnyObject {
    func customMenuBar(scrollTo index: Int)
}
class CustomMenuBar : UIView{
    let status : [ManagerData.status] = [.Accept,.StandBy,.Refusal,.Delete]
    weak var delegate: CustomMenuBarDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        setupCollectionViewLocation()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    let customTabBarCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .white
        cv.register(ManagerStatusMenuCollectionView.self, forCellWithReuseIdentifier: ManagerStatusMenuCollectionView.identifier)
        cv.isScrollEnabled = false
        return cv
    }()
    
    let indicatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .bamBoo_57CC4D
        return view
    }()
    
    var indicatorViewLeadingConstraint:NSLayoutConstraint!
    var indicatorViewWidthConstraint: NSLayoutConstraint!
    
    func setupCollectioView(){
        [customTabBarCollectionView].forEach { $0.delegate = self; $0.dataSource = self; $0.showsHorizontalScrollIndicator = false}
        let indexPath = IndexPath(item: 0, section: 0)
        customTabBarCollectionView.selectItem(at: indexPath, animated: false, scrollPosition: [])
    }
    func setupCollectionViewLocation(){
        setupCollectioView()
        self.addSubview(customTabBarCollectionView)
        customTabBarCollectionView.snp.makeConstraints {
            $0.top.trailing.leading.equalToSuperview()
            $0.height.equalTo(55)
        }
        self.addSubview(indicatorView)
        indicatorViewWidthConstraint = indicatorView.widthAnchor.constraint(equalToConstant: self.frame.width / 4)
        indicatorViewWidthConstraint.isActive = true
        indicatorViewLeadingConstraint = indicatorView.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        indicatorViewLeadingConstraint.isActive = true
        indicatorView.snp.makeConstraints {
            $0.height.equalTo(3)
            $0.bottom.equalToSuperview()
        }
    }
}
extension CustomMenuBar : UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ManagerStatusMenuCollectionView.identifier, for: indexPath) as? ManagerStatusMenuCollectionView else {return UICollectionViewCell()}
        cell.menuLabel.text = status[indexPath.row].rawValue
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.customMenuBar(scrollTo: indexPath.row)
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ManagerStatusMenuCollectionView.identifier, for: indexPath) as? ManagerStatusMenuCollectionView else {return }
        cell.menuLabel.textColor = .lightGray
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width / 4 , height: 55)
        
    }
}
//MARK:- UICollectionViewDelegateFlowLayout
extension CustomMenuBar: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

