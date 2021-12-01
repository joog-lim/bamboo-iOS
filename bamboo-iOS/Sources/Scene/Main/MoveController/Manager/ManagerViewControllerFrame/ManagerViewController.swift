//
//  ManagerViewController.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/10/05.
//

import UIKit

protocol managerModalDelegate: AnyObject{
    func accept(index : Int)
    func standBy(index: Int)
    func Delete(index: Int)
}
class ManagerViewController: BaseVC{
    //MARK: Properties
    private let vc = [AcceptViewController(),StandByViewController(),RefusalViewController(),DeleteViewController()]
    
    //MARK: - 모달 background 설정
    private let bgView = UIView().then {
        $0.backgroundColor = .black
        $0.alpha = 0
    }
    
    private let pageCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.isPagingEnabled = true
        cv.showsHorizontalScrollIndicator = false
        cv.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return cv
    }()
    
    private let customMenuBar = CustomMenuBar().then{ $0.translatesAutoresizingMaskIntoConstraints = false}
    //MARK: Life cycle
    override func configure() {
        super.configure()
        navigationSetting()
        setupCustomTabBar()
        addView()
        location()
        delegateAndDatasource()
    }

    //MARK: - Selector
    @objc private func navigationbarItemAction(){
        navigationController?.pushViewController(RuleViewController(), animated: true)
        navigationSetting()
    }
    @objc private func MainViewControllerNavigationAction(){
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: Setup view
    private func setupCustomTabBar(){
        customMenuBar.delegate = self
        customMenuBar.indicatorViewWidthConstraint.constant = self.view.frame.width / 4
    }
    private func addView(){
        self.view.addSubview(customMenuBar)
        self.view.addSubview(pageCollectionView)
    }
    //MARK: - Location
    private func location(){
        customMenuBar.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(55)
        }
        pageCollectionView.snp.makeConstraints {
            $0.top.equalTo(customMenuBar.snp.bottom)
            $0.trailing.leading.bottom.equalTo(view)
        }
    }
    
    //MARK: - DataSource ANd Delegate
    private func delegateAndDatasource(){
        [pageCollectionView].forEach{ $0.delegate = self;$0.dataSource = self}
        StandByViewController().delegate = self
    }
    
    //MARK: - Navigation Setting
    private func navigationSetting(){
        navigationController?.navigationCustomBar()
        navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(MainViewControllerNavigationAction))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "square.stack.3d.forward.dottedline.fill"), style: .plain, target: self, action: #selector(navigationbarItemAction))
        navigationItem.leftBarButtonItem?.tintColor = .bamBoo_57CC4D
        navigationItem.rightBarButtonItem?.tintColor = .rgb(red: 118, green: 177, blue: 87)
        navigationItem.applyImageNavigation()
    }
}

//MARK: - CollectionView Setting
extension ManagerViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as UICollectionViewCell
        cell.addSubview(vc[indexPath.row].view)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        customMenuBar.indicatorViewLeadingConstraint.constant = scrollView.contentOffset.x / 4
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let itemAt = Int(targetContentOffset.pointee.x / self.view.frame.width)
        let indexPath = IndexPath(item: itemAt, section: 0)
        customMenuBar.customTabBarCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension ManagerViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: bounds.width, height: pageCollectionView.frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

//MARK: - Modal Action
extension ManagerViewController {
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
//MARK: - Alert Action
extension ManagerViewController {
    //MARK: - AlertAction
    private func cellInsideBtnClickAction(index: Int){
        let actionSheetController  : UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let accessAction : UIAlertAction = UIAlertAction(title: "수락", style: .default) { _ in print("수락")
        }
        let refusalAction : UIAlertAction = UIAlertAction(title: "거절", style: .destructive) { _ in
            print("거절")
            self.StandByModal()
        }
        let closeAction : UIAlertAction = UIAlertAction(title: "Close", style: .cancel)
        [accessAction,refusalAction,closeAction].forEach{ actionSheetController.addAction($0)}
        present(actionSheetController, animated: true)
    }
    
    private func SeeMoreDetailBtnAction(index: Int){
        let actionSheetController  : UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let accessAction : UIAlertAction = UIAlertAction(title: "거절", style: .default) { _ in print("거절")
            self.DeleteModal()
        }
        let refusalAction : UIAlertAction = UIAlertAction(title: "삭제", style: .destructive) { _ in
            print("삭제")
        }
        let closeAction : UIAlertAction = UIAlertAction(title: "Close", style: .cancel)
        [accessAction,refusalAction,closeAction].forEach{ actionSheetController.addAction($0)}
        present(actionSheetController, animated: true)
    }
    
    //MARK: - Modal
    private func AcceptModal(index: Int){
        let EditContentModalModalsVC = EditContentModal.instance()
        EditContentModalModalsVC.delegate = self
        EditContentModalModalsVC.baseDelegate = self
        addDim()
        present(EditContentModalModalsVC, animated: true, completion: nil)
    }
    private func StandByModal(){
        let RefusalModalModalsVC = RefusalModal.instance()
        RefusalModalModalsVC.baseDelegate = self
        addDim()
        present(RefusalModalModalsVC, animated: true, completion: nil)
    }
    private func DeleteModal(){
        let RefusalModalModalsVC = RefusalModal.instance()
        RefusalModalModalsVC.baseDelegate = self
        addDim()
        present(RefusalModalModalsVC, animated: true, completion: nil)
    }
}


//MARK: - CustomMenuBar Delegate
extension ManagerViewController : CustomMenuBarDelegate{
    func customMenuBar(scrollTo index: Int) {
        let indexPath = IndexPath(row: index, section: 0)
        self.pageCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
}


extension ManagerViewController : EditContentModalProtocol{
    func onTapClose() {
        removeDim()
    }
}

extension ManagerViewController : BaseModalDelegate{
    func onTapClick() {
        self.removeDim()
    }
}

extension ManagerViewController : managerModalDelegate{
    func standBy(index: Int) {
        cellInsideBtnClickAction(index: index)
    }
    func accept(index: Int) {
        AcceptModal(index: index)
    }
    func Delete(index: Int) {
        SeeMoreDetailBtnAction(index: index)
    }
}
 
