//
//  UIColor+Extension.swift
//  MM
//
//  Created by 李成明 on 2021/12/30.
//

import Foundation
import UIKit

extension UIColor {
    static func initWithRGB(_ red: Int, _ green: Int, _ blue: Int) -> UIColor {
        return UIColor.init(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: 1)
    }
}
