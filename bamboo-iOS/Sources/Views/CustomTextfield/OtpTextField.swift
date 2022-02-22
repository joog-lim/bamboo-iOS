//
//  OtpView.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2022/02/22.
//

import UIKit

class OTPTextField : UITextField{
    override func deleteBackward() {
        if self.text?.count == 0 {
            findPrevious()
        } else {
            super.deleteBackward()
        }
      
    }
    
    func findPrevious() {
           if let nextField = self.superview?.viewWithTag(self.tag - 1) as? UITextField { //nextField.text?.count == 0 {
               nextField.becomeFirstResponder()
           } else {
               // Not found, so remove keyboard.
               self.resignFirstResponder()
           }
       }
}
