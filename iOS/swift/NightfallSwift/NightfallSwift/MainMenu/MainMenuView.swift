//
//  MainMenuView.swift
//  NightfallSwift
//
//  Created by Jimmy Lee on 2/8/26.
//

import UIKit

protocol MainMenuDelegate {
  func didTapInn()
  func didTapShop()
  func didTapItems()
  func didTapBattle()
}

class MainMenuView : UIView {
  var mainMenuDelegate: MainMenuDelegate?
  
  // MARK: Subviews
  private let inn = UIButton(type: .custom)
  private let shop = UIButton(type: .custom)
  private let items = UIButton(type: .custom)
  private let battle = UIButton(type: .custom)
  private let hp = UILabel()
  private let gold = UILabel()
  
  // MARK: UI Constants
  private let menuCornerRadius = 6.0
  private let themeColor = UIColor.cyan
  private let buttonToStatusSpacing = 100.0
  private let buttonSpacing = 50.0
  
  init() {
    super.init(frame: CGRectZero)
    self.backgroundColor = themeColor

    // MARK: Set Up Subviews
    inn.layer.cornerRadius = menuCornerRadius
    shop.layer.cornerRadius = menuCornerRadius
    items.layer.cornerRadius = menuCornerRadius
    battle.layer.cornerRadius = menuCornerRadius
    
    inn.addTarget(self, action: #selector(didTapInn), for: .touchUpInside)
    shop.addTarget(self, action: #selector(didTapShop), for: .touchUpInside)
    items.addTarget(self, action: #selector(didTapItems), for: .touchUpInside)
    battle.addTarget(self, action: #selector(didTapBattle), for: .touchUpInside)
    
    addSubview(inn)
    addSubview(shop)
    addSubview(items)
    addSubview(battle)
    addSubview(hp)
    addSubview(gold)
  }
  
  func configure(with viewState: MainMenuViewState) {
    hp.text = viewState.hpText
    gold.text = viewState.goldText
    
    clearConstraints()
    NSLayoutConstraint.activate(computedLayoutConstraints())
    layoutIfNeeded()
    
    inn.configuration = UIGuidelineButtonConfig(title: viewState.innTitle,
                                                      foregroundColor: themeColor)
    shop.configuration = UIGuidelineButtonConfig(title: viewState.shopTitle,
                                                       foregroundColor: themeColor)
    items.configuration = UIGuidelineButtonConfig(title: viewState.itemsTitle,
                                                        foregroundColor: themeColor)
    battle.configuration = UIGuidelineButtonConfig(title: viewState.battleTitle,
                                                         foregroundColor: themeColor)
  }
  
  func computedLayoutConstraints() -> [NSLayoutConstraint] {
    return [
      inn.centerXAnchor.constraint(equalTo: centerXAnchor),
      inn.bottomAnchor.constraint(equalTo: shop.topAnchor, constant: -buttonSpacing),
      inn.widthAnchor.constraint(equalToConstant: UIGuidelineButtonWidth),
//      inn.heightAnchor.constraint(equalToConstant: inn.computedHeightAnchor),
      
      shop.centerXAnchor.constraint(equalTo: centerXAnchor),
      shop.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -buttonSpacing),
      shop.widthAnchor.constraint(equalToConstant: UIGuidelineButtonWidth),
//      shop.heightAnchor.constraint(equalToConstant: shop.computedHeightAnchor),
      
      items.centerXAnchor.constraint(equalTo: centerXAnchor),
      items.centerYAnchor.constraint(equalTo: centerYAnchor, constant: buttonSpacing),
      items.widthAnchor.constraint(equalToConstant: UIGuidelineButtonWidth),
//      items.heightAnchor.constraint(equalToConstant: items.computedHeightAnchor),
      
      battle.centerXAnchor.constraint(equalTo: centerXAnchor),
      battle.topAnchor.constraint(equalTo: items.bottomAnchor, constant: buttonSpacing),
      battle.widthAnchor.constraint(equalToConstant: UIGuidelineButtonWidth),
//      battle.heightAnchor.constraint(equalToConstant: battle.computedHeightAnchor),
      
      hp.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UIGuidelineStatusSide),
      hp.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -UIGuidelineStatusBottom),
      hp.widthAnchor.constraint(equalToConstant: hp.computedWidthAnchor),
      hp.heightAnchor.constraint(equalToConstant: hp.computedHeightAnchor),
      
      gold.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: UIGuidelineStatusSide),
      gold.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -UIGuidelineStatusBottom + 30),
      gold.widthAnchor.constraint(equalToConstant: gold.computedWidthAnchor),
      gold.heightAnchor.constraint(equalToConstant: gold.computedHeightAnchor)
    ]
  }
  
  @objc func didTapInn() {
    mainMenuDelegate?.didTapInn()
  }
  
  @objc func didTapShop() {
    mainMenuDelegate?.didTapShop()
  }
  
  @objc func didTapItems() {
    mainMenuDelegate?.didTapItems()
  }
  
  @objc func didTapBattle() {
    mainMenuDelegate?.didTapBattle()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}
