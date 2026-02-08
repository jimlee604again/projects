//
//  MainMenuView.swift
//  NightfallSwift
//
//  Created by Jimmy Lee on 2/8/26.
//

import Foundation
import UIKit

class MainMenuView : UIView {

  private let innButton : UIButton
  
  private let menuButtonCornerRadius = 6.0
  private let shopButton : UIButton
  private let itemsButton : UIButton
  private let battleButton : UIButton
  
  init() {
    innButton = UIButton(type: .system)
    shopButton = UIButton(type: .system)
    itemsButton = UIButton(type: .system)
    battleButton = UIButton(type: .system)

    super.init(frame: CGRectZero)

    innButton.configuration = menuButtonConfig(title: "Inn")
    innButton.layer.cornerRadius = menuButtonCornerRadius
    
    shopButton.configuration = menuButtonConfig(title: "Shop")
    shopButton.layer.cornerRadius = menuButtonCornerRadius
    
    itemsButton.configuration = menuButtonConfig(title: "Items")
    itemsButton.layer.cornerRadius = menuButtonCornerRadius
    
    battleButton.configuration = menuButtonConfig(title: "Battle")
    battleButton.layer.cornerRadius = menuButtonCornerRadius
    
    addSubview(self.innButton)
    addSubview(self.shopButton)
    addSubview(self.itemsButton)
    addSubview(self.battleButton)
    
    let menuButtonSize = CGSize(width: 200,
                                height: innButton.sizeThatFits(self.bounds.size).height)
    
    innButton.translatesAutoresizingMaskIntoConstraints = false
    shopButton.translatesAutoresizingMaskIntoConstraints = false
    itemsButton.translatesAutoresizingMaskIntoConstraints = false
    battleButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      innButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      innButton.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -200),
      innButton.widthAnchor.constraint(equalToConstant: menuButtonSize.width),
      innButton.heightAnchor.constraint(equalToConstant: menuButtonSize.height),
      
      shopButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      shopButton.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -100),
      shopButton.widthAnchor.constraint(equalToConstant: menuButtonSize.width),
      shopButton.heightAnchor.constraint(equalToConstant: menuButtonSize.height),
      
      itemsButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      itemsButton.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0),
      itemsButton.widthAnchor.constraint(equalToConstant: menuButtonSize.width),
      itemsButton.heightAnchor.constraint(equalToConstant: menuButtonSize.height),
      
      battleButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      battleButton.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 100),
      battleButton.widthAnchor.constraint(equalToConstant: menuButtonSize.width),
      battleButton.heightAnchor.constraint(equalToConstant: menuButtonSize.height)
    ])
    
    self.backgroundColor = .cyan
  }
  
  func menuButtonConfig(title: String) -> UIButton.Configuration {
    var menuButtonConfig = UIButton.Configuration.filled()
    var attributedTitle = AttributedString(title)
    attributedTitle.font = UIFont.systemFont(ofSize: 20.0, weight: .bold)
    menuButtonConfig.attributedTitle = attributedTitle
    menuButtonConfig.baseForegroundColor = .black
    menuButtonConfig.background.backgroundColor = .orange
    menuButtonConfig.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 20, bottom: 16, trailing: 20)
    return menuButtonConfig
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}
