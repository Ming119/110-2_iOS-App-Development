//
//  extension.swift
//  midterm
//
//  Created by ming on 23/4/2022.
//

import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int, alpha: CGFloat = 1.0) {
        self.init(
            red:   CGFloat(red) / 255,
            green: CGFloat(green) / 255,
            blue:  CGFloat(blue) / 255,
            alpha: alpha
        )
    }
    
    convenience init(red: Int, green: Int, blue: Int, alpha: Int = 0xFF) {
        self.init(
            red:   CGFloat(red) / 255,
            green: CGFloat(green) / 255,
            blue:  CGFloat(blue) / 255,
            alpha: CGFloat(alpha) / 255
        )
    }
    
    convenience init(rgb: Int, alpha:CGFloat = 1.0) {
        self.init(
            red:   (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue:  (rgb) & 0xFF,
            alpha: alpha
        )
    }
    
    convenience init(argb: Int) {
        self.init(
            red:   (argb >> 16) & 0xFF,
            green: (argb >> 8) & 0xFF,
            blue:  (argb) & 0xFF,
            alpha: (argb >> 24) & 0xFF
        )
    }
}

extension Double {
    var trimAndStringify: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}
