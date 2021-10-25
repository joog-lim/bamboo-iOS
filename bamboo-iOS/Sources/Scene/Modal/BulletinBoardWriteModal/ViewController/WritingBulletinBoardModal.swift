//
//  WritingBulletinBoardModal.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/09/28.
//

import UIKit
import SnapKit
import RxKeyboard

class WritingBulletinBoardModal: BaseVC{
    //MARK - Tag Data
    let tagDataSection : [Data.tag] =  [.Humor,.Study,.DailyRoutine,.School,.Employment,.Relationship,.etc]
    //MARK: - Properties
    weak var delegate : WriteModalDelegate?
    
    private lazy var dropDownStatus : Bool = false
    
    private let transparentView = UIView()
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
    private let bgView = UIView().then{
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 40
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
        $0.addTarget(self, action: #selector(tagChooseBtnClick), for: .touchUpInside)
    }
    private let contentTv = AlertTextView(placeholder: "내용을 입력하세요.", fontSize: 10)
    private let passwordTitle = UILabel().then{
        $0.text = "Q. 학교 와이파이 비번은 무엇일까요?"
        $0.textColor = .black
        $0.font = UIFont(name: "NanumSquareRoundR", size: 12)
    }
    private let passwordTf = AlertTextField(placeholder: "답변을 입력하세요.", fontSize: 10)
    private let sendBtn = LoginButton(placeholder: "전송", cornerRadius: 10).then{
        $0.addTarget(self, action: #selector(sendTapClose), for: .touchUpInside)
    }
    
    //MARK: - StackView
    private lazy var titleStackView = UIStackView(arrangedSubviews: [titleTf,tagChooseBtn]).then{
        $0.axis = .horizontal
        $0.distribution = .fill
        $0.spacing = 5
    }
    private lazy var writeContentStackView = UIStackView(arrangedSubviews: [titleStackView,contentTv]).then{
        $0.spacing = 5
        $0.axis = .vertical
        $0.distribution = .fill
    }
    private lazy var passwordStackView = UIStackView(arrangedSubviews: [passwordTitle,passwordTf]).then{
        $0.axis = .vertical
        $0.spacing = 5
        $0.distribution = .fillProportionally
    }

    //모달 위치 조정
    static func instance() -> WritingBulletinBoardModal{
        return WritingBulletinBoardModal(nibName: nil, bundle: nil).then{
            $0.modalPresentationStyle = .overFullScreen
        }
    }
    
    //MARK: - Selectors
    @objc func onTapClose() {
        delegate?.onTapClose()
        dismiss(animated: true, completion: nil)
    }
    @objc func sendTapClose(){
        delegate?.onTapClose()
        dismiss(animated: true, completion: nil)
    }
    @objc func tagChooseBtnClick(){
        dropDownStatus == false ? addTagTableViewSetting(frames: tagChooseBtn.frame) : nil
    }
    
    //MARK: - Keyboard Setting
    @objc private func keyboardWillShow(_ sender: Notification) {
         self.view.frame.origin.y = -175 // Move view 150 points upward
    }
    @objc private func keyboardWillHide(_ sender: Notification) {
        self.view.frame.origin.y = 0 // Move view to original position
    }
    
    @objc func removeTagTableView(){
        removeDropDown()
    }
    
    //MARK: - HELPERS
    override func configure() {
        addView()
        location()
        keyboardSetting()
        StackViewSizing()
        DelegateAndDatasource()
        addTransparentsview(frame: transparentView.frame)
    }
    
    //MARK: - Delegate & DateSource
    private func DelegateAndDatasource(){
        contentTv.delegate = self
        tagChoose.delegate = self
        tagChoose.dataSource = self
    }
    
    //MARK: - AddView
    private func addView(){
        [transparentView,bgView].forEach { view.addSubview($0)}
        [tagSelectView,titleLabel,questionTitle,writeContentStackView,passwordStackView,sendBtn,tagChoose].forEach {bgView.addSubview($0)}
    }
    
    //MARK: - Location
    private func location(){
        bgView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(30)
            make.height.equalToSuperview().dividedBy(1.75)
        }
        titleLabel.snp.makeConstraints {
            $0.left.top.equalToSuperview().offset(bounds.width/15.625)
        }
        questionTitle.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(bounds.height/58)
            make.left.right.equalToSuperview().inset(bounds.width/15.625)
        }
        writeContentStackView.snp.makeConstraints { make in
            make.top.equalTo(questionTitle.snp.bottom).offset(bounds.height/162.4)
            make.left.right.equalToSuperview().inset(bounds.width/15.625)
            make.height.equalTo(bounds.height/5)
        }
        passwordStackView.snp.makeConstraints { make in
            make.top.equalTo(writeContentStackView.snp.bottom).offset(bounds.height/50.75)
            make.left.right.equalToSuperview().inset(bounds.width/15.625)
            make.height.equalTo(bounds.height/16.9166)
        }
        sendBtn.snp.makeConstraints { make in
            make.top.equalTo(passwordStackView.snp.bottom).offset(bounds.height/30.074)
            make.left.right.equalToSuperview().inset(bounds.width/15.625)
            make.height.equalTo(bounds.height/20.3)
        }
    }
    //MARK: - StackView 사이즈
    private func StackViewSizing(){
        tagChooseBtn.snp.makeConstraints { make in
            make.width.equalTo(bounds.width/5.77)
            make.height.equalTo(bounds.height/27.0666)
        }
        passwordTf.snp.makeConstraints { make in
            make.height.equalTo(bounds.height/27.0666)
        }
    }
    
    //MARK: - Gesture
    private func addTransparentsview(frame : CGRect){
        transparentView.frame = bounds
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(onTapClose))
        transparentView.addGestureRecognizer(tapgesture)
    }
    //MARK: - KeyboardSetting
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    //MARK: - Keyboard down
    private func keyboardSetting(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    //MARK: - DropDown Setting
    private func addTagTableViewSetting(frames: CGRect){
        tagSelectView.frame = view.frame
        tagChoose.frame = CGRect(x: bounds.width/1.31, y: bounds.height/10.4 + frames.height, width: frames.width, height: 0)
        tagChoose.reloadData()
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(removeTagTableView))
        tagSelectView.addGestureRecognizer(tapgesture)
        tagSelectView.alpha = 0
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut) { [self] in
            tagSelectView.alpha = 0.5
            dropDownStatus = true
            tagChoose.frame = CGRect(x: bounds.width/1.31, y: bounds.height/10.4 + frames.height, width: frames.width, height: CGFloat(CGFloat(tagDataSection.count) * bounds.height/32.48))
        }
    }
    //MARK: - DropDown remove
    private func removeDropDown(){
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut) { [self] in
            tagSelectView.alpha = 0
            dropDownStatus = false
            tagChoose.frame = CGRect(x: bounds.width/1.31, y: bounds.height/10.4 + tagChooseBtn.frame.height, width: tagChooseBtn.frame.width, height: 0)
        }
    }
}

//MARK: - TextView extension
extension WritingBulletinBoardModal : UITextViewDelegate{
        // TextView Place Holder
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.rgb(red: 196, green: 196, blue: 196) {
            textView.text = ""
            textView.textColor = UIColor.black
        }
    }
        // TextView Place Holder
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "내용을 입력하세요."
            textView.textColor = UIColor.rgb(red: 196, green: 196, blue: 196)
        }
    }
}

//MARK: - TableView
extension WritingBulletinBoardModal : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return WritingBulletinBoardModal().tagDataSection.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DropDownTableViewCell.identifier, for: indexPath) as? DropDownTableViewCell else {return UITableViewCell()}
        cell.model = WritingBulletinBoardModal().tagDataSection[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return bounds.height/32.48
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(tagDataSection[indexPath.row].rawValue)
        tagChooseBtn.setTitle(tagDataSection[indexPath.row].rawValue, for: .normal)
        removeDropDown()
    }
}
