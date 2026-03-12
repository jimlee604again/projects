//
//  PlayerLifeView.swift
//  LifeHack
//
//  Created by Jimmy Lee on 12/2/23.
//

import Foundation
import UIKit

class PlayerCounterView: UIView {
  var countLabel: UILabel

  init(backgroundColor: UIColor, poisonEnabled: Bool, frame: CGRect) {
    let label = UILabel(frame: CGRect(x: frame.origin.x,
                                      y: frame.origin.y,
                                      width: (poisonEnabled ? 0.5 : 1) * frame.width,
                                      height: frame.height))
    label.textColor = .black
    label.textAlignment = .center
    label.isHidden = false
    self.countLabel = label

    super.init(frame: frame)
    self.backgroundColor = backgroundColor
    self.addSubview(self.countLabel)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setAttributedText(attributedText: NSAttributedString) {
    self.countLabel.attributedText = attributedText
  }
  
  override func layoutSubviews() {
    self.countLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      self.countLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      self.countLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -24.0)
    ])
    return;
  }
  
  func setLifeColor(_ color: UIColor) {
    backgroundColor = color
  }
}
