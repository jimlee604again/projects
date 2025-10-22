//
//  TitleView.swift
//  LifeHack
//
//  Created by Jimmy Lee on 11/23/23.
//

import Foundation
import UIKit

class TitleView: UIView {
  var titleLabel: UILabel
  var startButton: UIButton
  
  init(frame: CGRect, 
       presentLifeTrackerAction: Selector,
       presentingController: UIViewController) {
    titleLabel = UILabel()
    startButton = UIButton()
    super.init(frame: frame)

    backgroundColor = lightBlueColor
    let titleAttributes = [NSAttributedString.Key.font: UIFont(name: "Chalkduster", size: 50.0)!]
    titleLabel.attributedText = NSAttributedString(string: "LifeHack", attributes:titleAttributes)
    titleLabel.textAlignment = .center

    let buttonTextAttributes = [
      NSAttributedString.Key.foregroundColor: UIColor.black,
      NSAttributedString.Key.font: UIFont(name: "MarkerFelt-Wide", size: 38.0)!
    ]
    let buttonAttributedText = NSAttributedString(string: "START", attributes: buttonTextAttributes)
    startButton.setAttributedTitle(buttonAttributedText, for: .normal)
    startButton.backgroundColor = .white
    startButton.layer.cornerRadius = 12
    startButton.addTarget(presentingController, action: presentLifeTrackerAction, for: .touchUpInside)

    addSubview(titleLabel)
    addSubview(startButton)
  }

  required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }

  override func layoutSubviews() {
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
      titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 200),
      titleLabel.heightAnchor.constraint(equalToConstant: 80),
      titleLabel.widthAnchor.constraint(equalToConstant: frame.width)
    ])

    startButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      startButton.centerXAnchor.constraint(equalTo: centerXAnchor),
      startButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -300),
      startButton.heightAnchor.constraint(equalToConstant: 60),
      startButton.widthAnchor.constraint(equalToConstant: 160)
    ])
  }
}
