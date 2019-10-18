//
//  UIColor+Hex.swift
//  ECE564_HOMEWORK
//
//  Created by Trevor Stevenson on 9/26/19.
//  Copyright © 2019 ece564. All rights reserved.
//

import UIKit

extension UIColor {
    /// Creates a color with a hex string and optional alpha value
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        guard hex.count != 0 else {
            self.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
            return
        }

        var hexString = hex

        if let first = hexString.first, first == "#" {
            hexString.removeFirst()
        }

        if let hexVal = UInt32(hexString, radix: 16) {
            let r = (hexVal & 0x00FF_0000) >> 16
            let g = (hexVal & 0x0000_FF00) >> 8
            let b = hexVal & 0x0000_00FF

            self.init(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: alpha)
        } else {
            self.init(red: 0, green: 0, blue: 0, alpha: 1.0)
        }
    }

    /// Makes the color darker by the given factor
    func darker(factor: CGFloat) -> UIColor {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0

        getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        return UIColor(red: red * factor, green: green * factor, blue: blue * factor, alpha: 1.0)
    }

    // MARK: - Custom colors

    /// Sky blue
    static let skyBlue = UIColor(hex: "87ceeb")

    /// Bright blue
    static let brightBlue = UIColor(hex: "2E86DE")

    /// Orange
    static let darkOrange = UIColor(hex: "FF9F43")

    /// Red
    static let strawberry = UIColor(hex: "EE5253")

    /// Dark Blue
    static let midnight = UIColor(hex: "161C28")

    /// Green
    static let mint = UIColor(hex: "10AC84")

    /// Gray
    static let cloudGray = UIColor(hex: "E0E0E0")

    /// White
    static let vanilla = UIColor(hex: "FFFFFF")

    /// Black
    static let dark = UIColor(hex: "000000")
}
