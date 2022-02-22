//
//  OTPInputView.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2022/02/22.
//

import UIKit
import SnapKit

public protocol OTPViewDelegate{
    func didFinishedEnterOTP(otpNumber: String)
    func otpNotValid()
}

public class OTPInputView : UIView{
    
    public var delegateOTP : OTPViewDelegate?
    public var maximumDigits : Int = 4
    
    override public func prepareForInterfaceBuilder() {
        setupTextFields()
    }
    
    override public func awakeFromNib() {
        setupTextFields()
    }
    
    fileprivate func setupTextFields(){
        backgroundColor = .clear
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        stackView.snp.makeConstraints{
            $0.width.height.centerX.centerY.equalToSuperview()
        }
        
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        
        for tag in 1...maximumDigits{
            let textField = OTPTextField()
            textField.tag = tag
            stackView.addArrangedSubview(textField)
            setupTextFieldStyle(textField)
        }
    }
    fileprivate func setupTextFieldStyle(_ textField : UITextField){
        textField.delegate = self
        textField.backgroundColor = .gray
        textField.keyboardType = .numberPad
        textField.textAlignment = .center
        textField.contentHorizontalAlignment = .center
        textField.textColor = .bamBoo_57CC4D
        textField.font = UIFont(name: "NanumSquareRoundR", size: 23)
    }
}

extension OTPInputView : UITextFieldDelegate{
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var nextTag = 0
        if string.checkBackspace(){
            textField.deleteBackward()
            return false
        }else if string.count == 1 {
            textField.text = string
            nextTag = textField.tag + 1
        }else if string.count == maximumDigits{
            var otpPasted = string
            for tag in 1...maximumDigits{
                guard let textfield = viewWithTag(tag) as? UITextField else {continue}
                textfield.text = String(otpPasted.removeFirst())
            }
            otpFetch()
        }
        if let nextTextfield = viewWithTag(nextTag) as? OTPTextField{
            nextTextfield.becomeFirstResponder()
        }else{
            if nextTag > maximumDigits{
                otpFetch()
            }
            endEditing(true)
        }
        return false
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        print("editing")
    }
    
    public func otpFetch(){
        var otp = ""
        for tag in 1...maximumDigits{
            guard let textfield = viewWithTag(tag) as? UITextField else {continue}
            otp += textfield.text!
        }
        
        if otp.count == maximumDigits{
            delegateOTP?.didFinishedEnterOTP(otpNumber: otp)
        }else{
            delegateOTP?.otpNotValid()
        }
    }
}
