//
//  ColorModel.swift
//  PythaSaga
//
//  Created by Jason Emanuel on 29/04/24.
//

import SwiftUI
    
extension UIColor {
    convenience init(hex: UInt32, alpha: CGFloat = 1.0) {
        let red = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hex & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(hex & 0x0000FF) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}

struct useColor {
    var bgColor = UIColor(hex: 0x87CEEB)
    var blueButtonColor = UIColor(hex: 0x003366)
    var redButtonColor = UIColor(hex: 0xCD5C5C)
    var titleColor = UIColor(hex: 0x556B2F)
    var popupBGColor = UIColor(hex: 0x6CA6CD)
}
