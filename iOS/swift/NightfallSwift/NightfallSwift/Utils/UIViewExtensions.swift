//
//  UIViewExtensions.swift
//  NightfallSwift
//
//  Created by Jimmy Lee on 3/2/26.
//

import UIKit

extension UIView {
  var computedWidthAnchor : CGFloat {
    guard let superview = self.superview else {
      return .zero
    }
    return self.sizeThatFits(superview.bounds.size).width
  }
  
  var computedHeightAnchor : CGFloat {
    guard let superview = self.superview else {
      return .zero
    }
    return self.sizeThatFits(superview.bounds.size).height
  }
  
  func clearConstraints() {
    for subview in self.subviews {
      subview.clearConstraints()
      subview.translatesAutoresizingMaskIntoConstraints = false
    }
    self.removeConstraints(self.constraints)
  }
}
