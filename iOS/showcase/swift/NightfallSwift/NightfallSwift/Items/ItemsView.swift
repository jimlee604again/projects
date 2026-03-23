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
  private let title = TitleTemplate()
  private let pageDescription = LabelTemplate()
  private let exit = ButtonTemplate(.close)
  private let usePotion = ButtonTemplate()
  private let itemsView = PlayerInventoryView()
  private let statusView = PlayerStatusView()

  init() {
    super.init(frame: CGRectZero)

    self.backgroundColor = themeColor

    // MARK: set up subviews
    title.font = UIFont.preferredFont(forTextStyle: .largeTitle)
    exit.addTarget(self, action: #selector(didTapExit), for: .touchUpInside)
    usePotion.addTarget(self, action: #selector(didTapUsePotion), for: .touchUpInside)

    addSubview(title)
    addSubview(itemsView)
    addSubview(usePotion)
    addSubview(statusView)
    addSubview(exit)

    NSLayoutConstraint.activate([
      title.centerXAnchor.constraint(equalTo: centerXAnchor),
      title.topAnchor.constraint(equalTo: topAnchor, constant: 100),

      itemsView.centerXAnchor.constraint(equalTo: centerXAnchor),
      itemsView.centerYAnchor.constraint(equalTo: centerYAnchor),

      usePotion.centerXAnchor.constraint(equalTo: centerXAnchor),
      usePotion.bottomAnchor.constraint(equalTo: statusView.topAnchor, constant: -UIGuidelineButtonToStatusSpacing),

      statusView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UIGuidelineStatusSide),
      statusView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -UIGuidelineStatusBottom),

      exit.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UIGuidelineExitLeading),
      exit.topAnchor.constraint(equalTo: topAnchor, constant: UIGuidelineExitTop)
    ])
  }

  func configure(with viewState: ItemsViewState) {
    title.text = viewState.title
    statusView.configure(hpText: viewState.hpText, goldText: viewState.goldText)
    pageDescription.text = viewState.pageDescription
    itemsView.configure(potionText: viewState.potionAmountText, crownText: viewState.crownAmountText)
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
