//
//  MainMenuView.swift
//  NightfallSwift
//
//  Created by Jimmy Lee on 2/8/26.
//

import Foundation
import UIKit

protocol MainMenuDelegate {
  func didTapInnButton()
}

class MainMenuView : UIView {

  private let innButton : UIButton
  
  private let menuButtonCornerRadius = 6.0
  private let shopButton : UIButton
  private let itemsButton : UIButton
  private let battleButton : UIButton
  private let hpLabel : UILabel
  private let goldLabel: UILabel
  
  // move to view model
  private let hp = 10
  private let gold = 0
  
  private let player: Player
  
  private let mainMenuDelegate: MainMenuDelegate
  
  init(player: Player, mainMenuDelegate: MainMenuDelegate) {
    innButton = UIButton(type: .system)
    shopButton = UIButton(type: .system)
    itemsButton = UIButton(type: .system)
    battleButton = UIButton(type: .system)
    hpLabel = UILabel()
    goldLabel = UILabel()
    self.player = player
    self.mainMenuDelegate = mainMenuDelegate

    super.init(frame: CGRectZero)

    innButton.configuration = menuButtonConfig(title: "Inn")
    innButton.layer.cornerRadius = menuButtonCornerRadius
    innButton.addTarget(self, action: #selector(didTapInnButton), for: .touchUpInside)
    
    shopButton.configuration = menuButtonConfig(title: "Shop")
    shopButton.layer.cornerRadius = menuButtonCornerRadius
    
    itemsButton.configuration = menuButtonConfig(title: "Items")
    itemsButton.layer.cornerRadius = menuButtonCornerRadius
    
    battleButton.configuration = menuButtonConfig(title: "Battle")
    battleButton.layer.cornerRadius = menuButtonCornerRadius
    
    hpLabel.attributedText = NSAttributedString(string: "HP: \(self.player.hp)")
    goldLabel.attributedText = NSAttributedString(string: "Gold: \(self.player.gold)")
    
    addSubview(self.innButton)
    addSubview(self.shopButton)
    addSubview(self.itemsButton)
    addSubview(self.battleButton)
    addSubview(self.hpLabel)
    addSubview(self.goldLabel)
    
    let menuButtonSize = CGSize(width: 200,
                                height: innButton.sizeThatFits(self.bounds.size).height)
    let hpLabelSize = hpLabel.sizeThatFits(self.bounds.size)
    let goldLabelSize = goldLabel.sizeThatFits(self.bounds.size)
    let labelBottomConstant = 100.0
    let labelSideConstant = 50.0
    
    innButton.translatesAutoresizingMaskIntoConstraints = false
    shopButton.translatesAutoresizingMaskIntoConstraints = false
    itemsButton.translatesAutoresizingMaskIntoConstraints = false
    battleButton.translatesAutoresizingMaskIntoConstraints = false
    hpLabel.translatesAutoresizingMaskIntoConstraints = false
    goldLabel.translatesAutoresizingMaskIntoConstraints = false
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
      battleButton.heightAnchor.constraint(equalToConstant: menuButtonSize.height),
      
      hpLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: labelSideConstant),
      hpLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -labelBottomConstant),
      hpLabel.widthAnchor.constraint(equalToConstant: hpLabelSize.width),
      hpLabel.heightAnchor.constraint(equalToConstant: hpLabelSize.height),
      
      goldLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -labelSideConstant),
      goldLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -labelBottomConstant),
      goldLabel.widthAnchor.constraint(equalToConstant: goldLabelSize.width),
      goldLabel.heightAnchor.constraint(equalToConstant: goldLabelSize.height)
    ])
    
    self.backgroundColor = .cyan
  }
  
  func menuButtonConfig(title: String) -> UIButton.Configuration {
    var menuButtonConfig = UIButton.Configuration.filled()
    var attributedTitle = AttributedString(title)
    attributedTitle.font = UIFont.systemFont(ofSize: 20.0, weight: .bold)
    menuButtonConfig.attributedTitle = attributedTitle
    menuButtonConfig.baseForegroundColor = .black
    menuButtonConfig.background.backgroundColor = .lightGray
    menuButtonConfig.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 20, bottom: 16, trailing: 20)
    return menuButtonConfig
  }
  
  @objc func didTapInnButton() {
    mainMenuDelegate.didTapInnButton()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}
