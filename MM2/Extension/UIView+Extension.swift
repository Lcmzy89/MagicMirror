//
//  UIView+extension.swift
//  MM
//
//  Created by 李成明 on 2021/12/30.
//

import Foundation
import UIKit

extension UIView {
    func addsubViews(_ views: [UIView]) {
        views.forEach { view in
            self.addSubview(view)
        }
    }
}
