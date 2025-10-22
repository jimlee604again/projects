//
//  UIColor+Hex.swift
//  LifeHack
//
//  Created by Jimmy Lee on 3/22/24.
//

import Foundation
import UIKit

//let poisonBackgroundColor = UIColor(red: 250/255.0, green: 155/255.0, blue: 240/255.0, alpha: 1.0)
//let pinkColor = UIColor(red: 255/255.0, green: 179/255.0, blue: 224/255.0, alpha: 1.0)
let pinkColor = UIColor(hex: "#ffb3e0ff")!
let lightBlueColor = UIColor(hex: "#99e9ffff")!
let purpleColor = UIColor(hex: "#b498cfff")!
let tealColor = UIColor(hex: "#9fffeaff")!

extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255

                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }

        return nil
    }
}
