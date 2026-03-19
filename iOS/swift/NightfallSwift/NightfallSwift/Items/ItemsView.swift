//
//  ItemsView.swift
//  NightfallSwift
//
//  Created by Jimmy Lee on 3/11/26.
//

import UIKit

protocol ItemsViewDelegate {
  func didTapExit()
  func didTapUsePotion()
}

class ItemsView : UIView {
  var itemsViewDelegate: ItemsViewDelegate?
  private let themeColor = UIColor.green

  // MARK: Subviews
  private let title = UIGuidelineTitleTemplate()
  private let pageDescription = UIGuidelineLabelTemplate()
  private let potionsCount = UIGuidelineLabelTemplate()
  private let crownsCount = UIGuidelineLabelTemplate()
  private let exit = UIGuidelineButtonTemplate(.close)
  private let usePotion = UIGuidelineButtonTemplate()
  private let hp = UIGuidelineLabelTemplate()
  private let gold = UIGuidelineLabelTemplate()
  private let items = UIGuidelineStackTemplate()
  private let status = UIGuidelineStackTemplate()

  init() {
    super.init(frame: CGRectZero)

    self.backgroundColor = themeColor

    // MARK: set up subviews
    title.font = UIFont.preferredFont(forTextStyle: .largeTitle)
    exit.addTarget(self, action: #selector(didTapExit), for: .touchUpInside)
    usePotion.addTarget(self, action: #selector(didTapUsePotion), for: .touchUpInside)

    items.alignment = .center
    items.addArrangedSubview(potionsCount)
    items.addArrangedSubview(crownsCount)
    status.addArrangedSubview(hp)
    status.addArrangedSubview(gold)

    addSubview(title)
    addSubview(items)
    addSubview(usePotion)
    addSubview(status)
    addSubview(exit)

    NSLayoutConstraint.activate([
      title.centerXAnchor.constraint(equalTo: centerXAnchor),
      title.topAnchor.constraint(equalTo: topAnchor, constant: 100),

      items.centerXAnchor.constraint(equalTo: centerXAnchor),
      items.centerYAnchor.constraint(equalTo: centerYAnchor),

      usePotion.centerXAnchor.constraint(equalTo: centerXAnchor),
      usePotion.bottomAnchor.constraint(equalTo: status.topAnchor, constant: -UIGuidelineButtonToStatusSpacing),

      status.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UIGuidelineStatusSide),
      status.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -UIGuidelineStatusBottom),

      exit.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UIGuidelineExitLeading),
      exit.topAnchor.constraint(equalTo: topAnchor, constant: UIGuidelineExitTop)
    ])
  }

  func configure(with viewState: ItemsViewState) {
    title.text = viewState.title
    hp.text = viewState.hpText
    gold.text = viewState.goldText
    pageDescription.text = viewState.pageDescription
    potionsCount.text = viewState.potionAmountText
    crownsCount.text = viewState.crownAmountText
    usePotion.configuration = UIGuidelineButtonConfig(title: viewState.usePotionText, foregroundColor: themeColor)
  }

  @objc func didTapExit() {
    itemsViewDelegate?.didTapExit()
  }

  @objc func didTapUsePotion() {
    itemsViewDelegate?.didTapUsePotion()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
