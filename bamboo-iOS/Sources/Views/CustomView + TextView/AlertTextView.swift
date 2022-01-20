//
//  AlertTextView.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/10/01.
//

import UIKit

class AlertTextView : UIView{

    private var  placeholder : String = .init()
    
    var tvContent : String?
    
    private let tf = UITextView().then{
        $0.clipsToBounds = true
        $0.textAlignment = .left
        $0.textColor = .rgb(red: 196, green: 196, blue: 196)
    }
    
    init(placeholder : String, fontSize : Int){
        super.init(frame: .zero)
        addview()
        backgroundColor = .white
        self.placeholder = placeholder
        tf.text = placeholder
        tf.delegate = self
        layer.applySketchShadow(color: .black, alpha: 0.25, x: 1, y: 1, blur: 4, spread: 0)
    }
    
    @available(* , unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        tf.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
    
    private func addview(){
        addSubviews(tf)
    }
    
}
extension AlertTextView : UITextViewDelegate{
    // TextView Place Holder
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = placeholder
            textView.textColor = UIColor.rgb(red: 196, green: 196, blue: 196)
        }
    }
    // TextView Place Holder
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.rgb(red: 196, green: 196, blue: 196) {
            tvContent = ""
            textView.text = ""
            textView.textColor = UIColor.black
        }
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let inputString = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard let oldString = textView.text, let newRange = Range(range,in:oldString) else {return true}
        let newString = oldString.replacingCharacters(in: newRange, with: inputString).trimmingCharacters(in: .whitespacesAndNewlines)
        let characterCount = newString.count
        guard characterCount <= 300 else  {return false}
        return true
    }
    //MARK: - textDidchange
    func textViewDidChange(_ textView: UITextView) {
        tvContent = textView.text
    }
}
