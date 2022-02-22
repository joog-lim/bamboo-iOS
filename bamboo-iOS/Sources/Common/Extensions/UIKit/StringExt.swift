//
//  StringExt.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2022/01/02.
//

import Foundation

extension String{
    var removedEscapeCharacters : String{
        //remove : "\"
        let removedEscapeWithQuotationMark = self.replacingOccurrences(of: "\\\"", with: "")
        //remove : "\"
        let removedEscape = removedEscapeWithQuotationMark.replacingOccurrences(of: "\\", with: "")
        return removedEscape
    }
    func checkBackspace() -> Bool{
        if let char = self.cString(using: String.Encoding.utf8){
            let isBackSpace = strcmp(char, "\\b")
            if (isBackSpace == -92){
                return true
            }
            return false
        }
        return false
    }
}
