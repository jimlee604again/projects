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

  // MARK: - Subviews
  private let title = UIGuidelineTitleTemplate()
  private let inn = UIGuidelineButtonTemplate()
  private let shop = UIGuidelineButtonTemplate()
  private let items = UIGuidelineButtonTemplate()
  private let battle = UIGuidelineButtonTemplate()
  private let hp = UIGuidelineLabelTemplate()
  private let gold = UIGuidelineLabelTemplate()

  // MARK: UI Constants
  private let themeColor = UIColor.cyan
  private let buttonToStatusSpacing = 100.0
  private let buttonSpacing = 50.0

  init() {
    super.init(frame: CGRectZero)
    self.backgroundColor = themeColor

    // MARK: Set Up Subviews
    inn.addTarget(self, action: #selector(didTapInn), for: .touchUpInside)
    shop.addTarget(self, action: #selector(didTapShop), for: .touchUpInside)
    items.addTarget(self, action: #selector(didTapItems), for: .touchUpInside)
    battle.addTarget(self, action: #selector(didTapBattle), for: .touchUpInside)

    addSubview(title)
    addSubview(inn)
    addSubview(shop)
    addSubview(items)
    addSubview(battle)
    addSubview(hp)
    addSubview(gold)

    NSLayoutConstraint.activate([
      title.centerXAnchor.constraint(equalTo: centerXAnchor),
      title.topAnchor.constraint(equalTo: topAnchor, constant: UIGuidelineTitleTopInset),

      inn.centerXAnchor.constraint(equalTo: centerXAnchor),
      inn.bottomAnchor.constraint(equalTo: shop.topAnchor, constant: -buttonSpacing),
      inn.widthAnchor.constraint(equalToConstant: UIGuidelineButtonWidth),

      shop.centerXAnchor.constraint(equalTo: centerXAnchor),
      shop.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -buttonSpacing),
      shop.widthAnchor.constraint(equalToConstant: UIGuidelineButtonWidth),

      items.centerXAnchor.constraint(equalTo: centerXAnchor),
      items.centerYAnchor.constraint(equalTo: centerYAnchor, constant: buttonSpacing),
      items.widthAnchor.constraint(equalToConstant: UIGuidelineButtonWidth),

      battle.centerXAnchor.constraint(equalTo: centerXAnchor),
      battle.topAnchor.constraint(equalTo: items.bottomAnchor, constant: buttonSpacing),
      battle.widthAnchor.constraint(equalToConstant: UIGuidelineButtonWidth),

      hp.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UIGuidelineStatusSide),
      hp.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -UIGuidelineStatusBottom),

      gold.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UIGuidelineStatusSide),
      gold.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -UIGuidelineStatusBottom + 30)
    ])
  }

  func configure(with viewState: MainMenuViewState) {
    title.text = viewState.title
    hp.text = viewState.hpText
    gold.text = viewState.goldText

    inn.configuration = UIGuidelineButtonConfig(title: viewState.innTitle,
                                                      foregroundColor: themeColor)
    shop.configuration = UIGuidelineButtonConfig(title: viewState.shopTitle,
                                                       foregroundColor: themeColor)
    items.configuration = UIGuidelineButtonConfig(title: viewState.itemsTitle,
                                                        foregroundColor: themeColor)
    battle.configuration = UIGuidelineButtonConfig(title: viewState.battleTitle,
                                                         foregroundColor: themeColor)
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
