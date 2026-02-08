//
//  TitleView.swift
//  NightfallSwift
//
//  Created by Jimmy Lee on 1/21/26.
//

import Foundation
import UIKit

class TitleView : UIView {
  private let titleText : UILabel
  private let startButton : UIButton
  
  init() {
    self.titleText = UILabel()
    self.titleText.text = "Nightfall"
    self.titleText.textColor = .white
    self.titleText.font = UIFont.boldSystemFont(ofSize: 40.0)
    
    self.startButton = UIButton(type: .system)
    var startButtonConfig = UIButton.Configuration.filled()
    var attributedTitle = AttributedString("Start")
    attributedTitle.font = UIFont.systemFont(ofSize: 20.0, weight: .bold)
    startButtonConfig.attributedTitle = attributedTitle
    startButtonConfig.baseForegroundColor = .black
    self.startButton.configuration = startButtonConfig
    
    self.startButton.backgroundColor = .blue
    self.startButton.layer.cornerRadius = 6.0
    startButtonConfig.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20)
    self.startButton.configuration = startButtonConfig

    super.init(frame: CGRectZero)

    self.backgroundColor = .black
    self.addSubview(self.titleText)
    self.addSubview(self.startButton)

    let titleSizeThatFits = titleText.sizeThatFits(self.bounds.size)
    let buttonSizeThatFits = startButton.sizeThatFits(self.bounds.size)
    
    titleText.translatesAutoresizingMaskIntoConstraints = false
    startButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      titleText.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      titleText.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -200),
      titleText.widthAnchor.constraint(equalToConstant: titleSizeThatFits.width),
      titleText.heightAnchor.constraint(equalToConstant: titleSizeThatFits.height),
      
      startButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      startButton.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 100),
      startButton.widthAnchor.constraint(equalToConstant: buttonSizeThatFits.width),
      startButton.heightAnchor.constraint(equalToConstant: buttonSizeThatFits.height)
    ])
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
