//
//  CustomAlertController.swift
//  Instagrid
//
//  Created by antoine radice on 08/03/2021.
//
import UIKit
import Foundation

class CustomAlertController: UIAlertController {
    override open func viewDidLoad() {
            super.viewDidLoad()
            pruneNegativeWidthConstraints()
        }

        private func pruneNegativeWidthConstraints() {
            for subView in self.view.subviews {
                for constraint in subView.constraints where constraint.debugDescription.contains("width == - 16") {
                    subView.removeConstraint(constraint)
                }
            }
        }
}
