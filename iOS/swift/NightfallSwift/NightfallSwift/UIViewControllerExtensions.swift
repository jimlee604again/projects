//
//  UIViewControllerExtensions.swift
//  NightfallSwift
//
//  Created by Jimmy Lee on 3/16/26.
//

import UIKit

public extension UIViewController {
  func presentSimpleAlert(title: String?, message: String?) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: UIGuidelineAlertConfirm, style: .default))
    present(alert, animated: false)
  }
}
