//
//  AlertTextView.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/10/01.
//

import UIKit

class AlertTextView : UITextView{
    private var  placeholder : String = .init()
    
    init(placeholder : String, fontSize : Int){
        super.init(frame: CGRect.zero, textContainer: nil)
        backgroundColor = .white
        textAlignment = .left
        textColor = .rgb(red: 196, green: 196, blue: 196)
        self.placeholder = placeholder
        text = placeholder
        isEditable = true
        delegate = self
        clipsToBounds = true
        layer.cornerRadius = 5
        layer.applySketchShadow(color: .black, alpha: 0.25, x: 1, y: 1, blur: 4, spread: 0)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
            textView.text = ""
            textView.textColor = UIColor.black
        }
    }
}
