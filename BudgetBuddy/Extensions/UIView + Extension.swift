//
//  UIView + Extension.swift
//  BudgetBuddy
//
//  Created by Alisher Zinullayev on 07.02.2024.
//

import Foundation
import UIKit

extension UIView {

    func roundCorners(_ corners: CACornerMask, radius: CGFloat) {
        self.layer.maskedCorners = corners
        self.layer.cornerRadius = radius
    }
}
