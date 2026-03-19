//
//  UITemplates.swift
//  NightfallSwift
//
//  Created by Jimmy Lee on 3/19/26.
//

import UIKit

func TitleTemplate() -> UILabel {
  let label = UILabel()
  label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
  label.textAlignment = .center
  label.translatesAutoresizingMaskIntoConstraints = false
  return label
}

func LabelTemplate() -> UILabel {
  let label = UILabel()
  label.textAlignment = .center
  label.translatesAutoresizingMaskIntoConstraints = false
  return label
}

func ButtonTemplate(_ type: UIButton.ButtonType = .custom) -> UIButton {
  let button = UIButton(type: type)
  button.translatesAutoresizingMaskIntoConstraints = false
  return button
}

func StackTemplate() -> UIStackView {
  let stack = UIStackView(frame: .zero)
  stack.axis = .vertical
  stack.alignment = .leading
  stack.distribution = .fill
  stack.spacing = 8
  stack.translatesAutoresizingMaskIntoConstraints = false
  return stack
}
