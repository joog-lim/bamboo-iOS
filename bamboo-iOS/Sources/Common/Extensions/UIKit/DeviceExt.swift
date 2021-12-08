//
//  DeviceExt.swift
//  bamboo-iOS
//
//  Created by Ji-hoon Ahn on 2021/12/03.
//

import UIKit

//MARK: - Device 구분
extension UIDevice {
    public var isiPhone: Bool {
      if UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone {
          return true
      }
      return false
    }
    public var isiPad: Bool {
        if UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad {
            return true
        }
        return false
    }
}
