//
//  UIGuidelineHelpers.swift
//  NightfallSwift
//
//  Created by Jimmy Lee on 2/26/26.
//

import UIKit

let UIGuidelineExitLeading: CGFloat = 40
let UIGuidelineExitTop: CGFloat = 70
let UIGuidelineStatusBottom = 100.0
let UIGuidelineStatusSide = 50.0
let UIGuidelineButtonWidth = 200.0
let UIGuidelineTitleTopInset = 100.0

let UIGuidelineAlertConfirm = "OK"

let UIGuidelineTitleFont = UIFont.preferredFont(forTextStyle: .largeTitle)

func UIGuidelineButtonConfig(title: String, foregroundColor: UIColor) -> UIButton.Configuration {
  var menuButtonConfig = UIButton.Configuration.filled()
  var attributedTitle = AttributedString(title)
  attributedTitle.font = UIFont.systemFont(ofSize: 20.0, weight: .bold)
  menuButtonConfig.attributedTitle = attributedTitle
  menuButtonConfig.baseForegroundColor = foregroundColor
  menuButtonConfig.background.backgroundColor = .black
  menuButtonConfig.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 20, bottom: 16, trailing: 20)
  return menuButtonConfig
}
