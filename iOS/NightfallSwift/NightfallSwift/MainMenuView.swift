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
  func didTapBattleButton()
}

class MainMenuView : UIView {

  // MARK: subviews
  private let innButton : UIButton
  private let shopButton : UIButton
  private let itemsButton : UIButton
  private let battleButton : UIButton
  private let hpLabel : UILabel
  private let goldLabel: UILabel
  
  // MARK: UI constants
  private let menuButtonCornerRadius = 6.0
  let labelBottomConstant = 100.0
  let labelSideConstant = 50.0
  var lastConstraints: [NSLayoutConstraint] = []
  
  // MARK: computed UI variables
  var menuButtonSize : CGSize {
    CGSize(width: 200,
           height: innButton.sizeThatFits(self.bounds.size).height)
  }
  var hpLabelSize : CGSize {
    return hpLabel.sizeThatFits(self.bounds.size)
  }
  var goldLabelSize : CGSize {
    return goldLabel.sizeThatFits(self.bounds.size)
  }

  // MARK: Model
  private let mainMenuViewModel: MainMenuViewModel
  
  // MARK: Delegate
  var mainMenuDelegate: MainMenuDelegate?
  
  init(mainMenuViewModel: MainMenuViewModel) {
    innButton = UIButton(type: .system)
    shopButton = UIButton(type: .system)
    itemsButton = UIButton(type: .system)
    battleButton = UIButton(type: .system)
    hpLabel = UILabel()
    goldLabel = UILabel()
    self.mainMenuViewModel = mainMenuViewModel

    super.init(frame: CGRectZero)
    self.backgroundColor = .cyan

    innButton.configuration = menuButtonConfig(title: "Inn")
    innButton.layer.cornerRadius = menuButtonCornerRadius
    innButton.addTarget(self, action: #selector(didTapInnButton), for: .touchUpInside)
    
    shopButton.configuration = menuButtonConfig(title: "Shop")
    shopButton.layer.cornerRadius = menuButtonCornerRadius
    
    itemsButton.configuration = menuButtonConfig(title: "Items")
    itemsButton.layer.cornerRadius = menuButtonCornerRadius
    
    battleButton.configuration = menuButtonConfig(title: "Battle")
    battleButton.layer.cornerRadius = menuButtonCornerRadius
    battleButton.addTarget(self, action: #selector(didTapBattleButton), for: .touchUpInside)
    
    hpLabel.attributedText = NSAttributedString(string: mainMenuViewModel.playerHealthDisplayText())
    goldLabel.attributedText = NSAttributedString(string: mainMenuViewModel.playerGoldDisplayText())
    
    addSubview(self.innButton)
    addSubview(self.shopButton)
    addSubview(self.itemsButton)
    addSubview(self.battleButton)
    addSubview(self.hpLabel)
    addSubview(self.goldLabel)

    innButton.translatesAutoresizingMaskIntoConstraints = false
    shopButton.translatesAutoresizingMaskIntoConstraints = false
    itemsButton.translatesAutoresizingMaskIntoConstraints = false
    battleButton.translatesAutoresizingMaskIntoConstraints = false
    hpLabel.translatesAutoresizingMaskIntoConstraints = false
    goldLabel.translatesAutoresizingMaskIntoConstraints = false
    HACKactivateConstraints()
  }
  
  func HACKactivateConstraints() {
    NSLayoutConstraint.deactivate(lastConstraints)
    
    lastConstraints = [
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
      
      goldLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: labelSideConstant),
      goldLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -labelBottomConstant + 30),
      goldLabel.widthAnchor.constraint(equalToConstant: goldLabelSize.width),
      goldLabel.heightAnchor.constraint(equalToConstant: goldLabelSize.height)
    ]
    
    NSLayoutConstraint.activate(lastConstraints)
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
    mainMenuDelegate?.didTapInnButton()
  }
  
  @objc func didTapBattleButton() {
    mainMenuDelegate?.didTapBattleButton()
  }
  
  func dataDidChange() {
    setNeedsUpdateProperties()
  }
  
  override func updateProperties() {
    super.updateProperties()
    // Reading the properties here automatically tracks them
    hpLabel.attributedText = NSAttributedString(string: mainMenuViewModel.playerHealthDisplayText())
    goldLabel.attributedText = NSAttributedString(string: mainMenuViewModel.playerGoldDisplayText())
    
    HACKactivateConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}
