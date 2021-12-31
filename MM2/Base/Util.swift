//
//  Util.swift
//  MM
//
//  Created by 李成明 on 2021/12/30.
//

import Foundation
import UIKit

class Util {
    static func getStateTopHeight() -> CGFloat {
        var statusBarHeight:CGFloat = 0.0
        if #available(iOS 13.0, *) {
            let stateBarManager = UIApplication.shared.keyWindow?.windowScene?.statusBarManager
            statusBarHeight = stateBarManager?.statusBarFrame.size.height ?? 0
        } else {
            statusBarHeight = UIApplication.shared.statusBarFrame.size.height
        }
        return statusBarHeight
    }
    
    static func isLetterWithDigital(_ string:String) -> Bool {
        let regex = NSPredicate(format: "SELF MATCHES %@","^[0-9a-zA-Z]{1,}$")
        return regex.evaluate(with: string)
    }
}
