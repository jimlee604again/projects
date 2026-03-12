//
//  UIViewExtensions.swift
//  NightfallSwift
//
//  Created by Jimmy Lee on 3/2/26.
//

import UIKit

extension UIView {
  func clearConstraints() {
    for subview in self.subviews {
      subview.clearConstraints()
    }
    self.removeConstraints(self.constraints)
  }
}
