//
//  UIGuidelineHelpers.swift
//  NightfallSwift
//
//  Created by Jimmy Lee on 2/26/26.
//

import UIKit

let UIGuidelineExitLeading = 40.0
let UIGuidelineExitTop = 70.0
let UIGuidelineStatusBottom = 100.0
let UIGuidelineStatusSide = 50.0
let UIGuidelineButtonWidth = 200.0
let UIGuidelineTitleTopInset = 100.0
let UIGuidelineDescriptionGap = 30.0
let UIGuidelineTitleBottomInset = 100.0
let UIGuidelineButtonToStatusSpacing = 50.0
let UIGuidelineButtonFont = UIFont.systemFont(ofSize: 20.0, weight: .bold)

let UIGuidelineAlertConfirm = "OK"

func UIGuidelineButtonConfig(title: String, foregroundColor: UIColor) -> UIButton.Configuration {
  var menuButtonConfig = UIButton.Configuration.filled()
  var attributedTitle = AttributedString(title)
  attributedTitle.font = UIGuidelineButtonFont
  menuButtonConfig.attributedTitle = attributedTitle
  menuButtonConfig.baseForegroundColor = foregroundColor
  menuButtonConfig.background.backgroundColor = .black
  menuButtonConfig.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 20, bottom: 16, trailing: 20)
  menuButtonConfig.cornerStyle = .medium
  return menuButtonConfig
}

func UIGuidelineTitleTemplate() -> UILabel {
  let label = UILabel()
  label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
  label.textAlignment = .center
  label.translatesAutoresizingMaskIntoConstraints = false
  return label
}

func UIGuidelineLabelTemplate() -> UILabel {
  let label = UILabel()
  label.textAlignment = .center
  label.translatesAutoresizingMaskIntoConstraints = false
  return label
}

func UIGuidelineButtonTemplate(_ type: UIButton.ButtonType = .custom) -> UIButton {
  let button = UIButton(type: type)
  button.translatesAutoresizingMaskIntoConstraints = false
  return button
}

func UIGuidelineStackTemplate() -> UIStackView {
  let stack = UIStackView(frame: .zero)
  stack.axis = .vertical
  stack.alignment = .leading
  stack.distribution = .fill
  stack.spacing = 8
  stack.translatesAutoresizingMaskIntoConstraints = false
  return stack
}
