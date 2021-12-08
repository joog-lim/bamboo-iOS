//
//  WritingBulletinBoardModal.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/09/28.
//

import UIKit
import SnapKit
import RxKeyboard
import PanModal

protocol WriteModalDelegate : AnyObject{
    func updateWrite()
}

class WritingBulletinBoardModal: baseVC<WritingBulletinBoardReactor>{
    //MARK - Tag Data
    private let tagDataSection : [Data.tag] =  [.Humor,.Study,.DailyRoutine,.School,.Employment,.Relationship,.etc]
    //MARK: - Properties
    weak var delegate : WriteModalDelegate?
    
    private lazy var dropDownStatus : Bool = false
    
    private let tagSelectView = UIView()
    private let tagChoose = UITableView().then{
        $0.register(DropDownTableViewCell.self, forCellReuseIdentifier: DropDownTableViewCell.identifier)
        $0.backgroundColor = .white
        $0.separatorColor = .clear
        $0.isScrollEnabled = false
        $0.layer.cornerRadius = 5
        $0.layer.borderWidth = 0.5
        $0.layer.borderColor = UIColor.bamBoo_57CC4D.cgColor
    }

    private let titleLabel = UILabel().then{
        $0.text = "글 입력하기"
        $0.font = UIFont(name: "NanumSquareRoundB", size: 16)
        $0.textColor = .bamBoo_57CC4D
    }
    private let questionTitle = UILabel().then{
        $0.textColor = .black
        $0.text = "올리고 싶은 글을 입력해주세요!"
        $0.font = UIFont(name: "NanumSquareRoundR", size: 12)
    }
    private let titleTf = AlertTextField(placeholder: "제목을 입력하세요.", fontSize: 10)
    private let tagChooseBtn = LoginButton(placeholder: "태그선택", cornerRadius: 5).then{
        $0.titleLabel?.font = UIFont(name: "NanumSquareRoundB", size: 12)
    }
    private let contentTv = AlertTextView(placeholder: "내용을 입력하세요.", fontSize: 10)
    private let passwordTitle = UILabel().then{
        $0.text = "Q. 학교 와이파이 비번은 무엇일까요?"
        $0.textColor = .black
        $0.font = UIFont(name: "NanumSquareRoundR", size: 12)
    }
    private let passwordTf = AlertTextField(placeholder: "답변을 입력하세요.", fontSize: 10)
    private let sendBtn = LoginButton(placeholder: "전송", cornerRadius: 10).then{
        $0.titleLabel?.font = UIFont(name: "NanumSquareRoundR", size: 13)
    }
    
    //MARK: - StackView
    private lazy var passwordStackView = UIStackView(arrangedSubviews: [passwordTitle,passwordTf]).then{
        $0.axis = .vertical
        $0.spacing = 5
        $0.distribution = .fillEqually
    }
    
    //MARK: - HELPERS
    override func configureUI() {
        super.configureUI()
        DelegateAndDatasource()
    }
    //MARK: - AddView
    override func addView() {
        super.addView()
        [titleLabel,questionTitle,titleTf,tagChooseBtn,contentTv,passwordStackView,sendBtn,tagChoose].forEach {view.addSubview($0)}
    }
    
    //MARK: - Location
    override func setLayout() {
        super.setLayout()
        iphoneLocation()
        iPadLocation()
        questionTitle.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(bounds.height/58)
            $0.left.right.equalToSuperview().inset(bounds.width/15.625)
        }
    }

    //MARK: - Delegate & DateSource
    private func DelegateAndDatasource(){
        contentTv.delegate = self
        [tagChoose].forEach{ $0.delegate = self; $0.dataSource = self}
    }
    //MARK: - KeyboardSetting
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    override func bindView(reactor: WritingBulletinBoardReactor) {
        super.bindView(reactor: reactor)

        tagChooseBtn.rx.tap
            .subscribe(onNext:{ [self] in
                addTagTableViewSetting(frames: tagChooseBtn.frame)
            }).disposed(by: disposeBag)
    }
}
//MARK: - DropDown
extension WritingBulletinBoardModal{
    //MARK: - DropDown Setting
    private func addTagTableViewSetting(frames: CGRect){
        tagSelectView.frame = view.frame
        self.view.addSubview(tagSelectView)
        tagChoose.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
        self.view.addSubview(tagChoose)
        tagChoose.reloadData()
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(removeDropDown))
        tagSelectView.addGestureRecognizer(tapgesture)
        tagSelectView.alpha = 0
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: { [self] in
            tagSelectView.alpha = 0.2
            if UIDevice.current.isiPad{
                tagChoose.frame = CGRect(x: frames.origin.x,
                                         y: frames.origin.y + frames.height + 5,
                                         width: frames.width,
                                         height: 25 * CGFloat(tagDataSection.count))
            }else if UIDevice.current.isiPhone{
                tagChoose.frame = CGRect(x: frames.origin.x,
                                         y: frames.origin.y + frames.height + 5,
                                         width: frames.width,
                                         height: bounds.height/27 * CGFloat(tagDataSection.count))
            }
        }, completion: nil)
    }
    //MARK: - DropDown remove
    @objc private func removeDropDown(){
        let frames = tagChooseBtn.frame
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.tagSelectView.alpha = 0
            self.tagChoose.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
        }, completion: nil)
    }
}

//MARK: - TextView extension
extension WritingBulletinBoardModal : UITextViewDelegate{
    // TextView Place Holder
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "내용을 입력하세요."
            textView.textColor = UIColor.rgb(red: 196, green: 196, blue: 196)
        }
    }
    // TextView Place Holder
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.rgb(red: 196, green: 196, blue: 196) {
            textView.text = ""
            textView.textColor = UIColor.black
        }
    }
}

//MARK: - TableView
extension WritingBulletinBoardModal : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return WritingBulletinBoardModal(reactor: .init()).tagDataSection.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DropDownTableViewCell.identifier, for: indexPath) as? DropDownTableViewCell else {return UITableViewCell()}
        cell.model = WritingBulletinBoardModal(reactor: .init()).tagDataSection[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if UIDevice.current.isiPad{
            return 25
        }else if UIDevice.current.isiPhone{
            return bounds.height/27
        }
        return 0
        
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(tagDataSection[indexPath.row].rawValue)
        tagChooseBtn.setTitle(tagDataSection[indexPath.row].rawValue, for: .normal)
        removeDropDown()
    }
}
//MARK: - Location
extension WritingBulletinBoardModal{
    //MARK: - iPAD
    private func iPadLocation(){
        if UIDevice.current.isiPad{
            titleLabel.snp.makeConstraints {
                $0.left.equalToSuperview().offset(bounds.width/15.625)
                $0.top.equalToSuperview().offset(24)
            }
            titleTf.snp.makeConstraints{
                $0.top.equalTo(questionTitle.snp.bottom).offset(bounds.height/162.4)
                $0.left.equalToSuperview().offset(bounds.width/15.625)
                $0.right.equalTo(tagChooseBtn.snp.left).inset(bounds.width/75 * -1)
                $0.height.equalTo(30)
            }
            tagChooseBtn.snp.makeConstraints {
                $0.top.equalTo(titleTf)
                $0.right.equalToSuperview().inset(bounds.width/15.625)
                $0.width.equalTo(60)
                $0.height.equalTo(titleTf)
            }
            contentTv.snp.makeConstraints {
                $0.top.equalTo(titleTf.snp.bottom).offset(bounds.height/162.4)
                $0.left.right.equalToSuperview().inset(bounds.width/15.625)
                $0.height.equalTo(154)
            }
            passwordStackView.snp.makeConstraints {
                $0.top.equalTo(contentTv.snp.bottom).offset(bounds.height/50.75)
                $0.left.right.equalToSuperview().inset(bounds.width/15.625)
                $0.height.equalTo(60)
            }
            sendBtn.snp.makeConstraints {
                $0.top.equalTo(passwordStackView.snp.bottom).offset(27)
                $0.left.right.equalToSuperview().inset(bounds.width/15.625)
                $0.height.equalTo(30)
            }
        }
    }
    //MARK: - iPhone
    private func iphoneLocation(){
        if UIDevice.current.isiPhone{
            titleLabel.snp.makeConstraints {
                $0.left.equalToSuperview().offset(bounds.width/15.625)
                $0.top.equalToSuperview().offset(bounds.height/33.8333)
            }
            titleTf.snp.makeConstraints{
                $0.top.equalTo(questionTitle.snp.bottom).offset(bounds.height/162.4)
                $0.left.equalToSuperview().offset(bounds.width/15.625)
                $0.right.equalTo(tagChooseBtn.snp.left).inset(bounds.width/75 * -1)
                $0.height.equalTo(bounds.height/27.0666)
            }
            tagChooseBtn.snp.makeConstraints {
                $0.top.equalTo(titleTf)
                $0.right.equalToSuperview().inset(bounds.width/15.625)
                $0.width.equalTo(bounds.width/5.77)
                $0.height.equalTo(titleTf)
            }
            contentTv.snp.makeConstraints {
                $0.top.equalTo(titleTf.snp.bottom).offset(bounds.height/162.4)
                $0.left.right.equalToSuperview().inset(bounds.width/15.625)
                $0.height.equalTo(bounds.height/7.51851)
            }
            passwordStackView.snp.makeConstraints {
                $0.top.equalTo(contentTv.snp.bottom).offset(bounds.height/50.75)
                $0.left.right.equalToSuperview().inset(bounds.width/15.625)
                $0.height.equalTo(bounds.height/12)
            }
            sendBtn.snp.makeConstraints {
                $0.top.equalTo(passwordStackView.snp.bottom).offset(bounds.height/30.074)
                $0.left.right.equalToSuperview().inset(bounds.width/15.625)
                $0.height.equalTo(bounds.height/20.3)
            }
        }
    }
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
}

extension WritingBulletinBoardModal : PanModalPresentable{

    var panScrollable: UIScrollView? {
        return nil
    }

    var longFormHeight: PanModalHeight {
            return .contentHeight(bounds.height/2)
    }
    
    var shortFormHeight: PanModalHeight{
        return .contentHeight(bounds.height/2)
    }
    
    var anchorModalToLongForm: Bool {
        return false
    }
    

    var shouldRoundTopCorners: Bool {
        return false
    }
    
    var panModalBackgroundColor: UIColor{
        return .black.withAlphaComponent(0.1)
    }
    
}
