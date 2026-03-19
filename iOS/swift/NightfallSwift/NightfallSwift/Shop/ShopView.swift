//
//  ShopView.swift
//  NightfallSwift
//
//  Created by Jimmy Lee on 3/1/26.
//

import UIKit

protocol ShopViewDelegate {
  func didTapBuyPotion()
  func didTapBuyCrown()
  func didTapExit()
}

class ShopView : UIView {
  var shopViewDelegate: ShopViewDelegate?
  private let themeColor = UIColor.yellow

  // MARK: Subviews
  private let title = UIGuidelineTitleTemplate()
  private let pageDescription = UIGuidelineLabelTemplate()
  private let buyPotion = UIGuidelineButtonTemplate()
  private let buyCrown = UIGuidelineButtonTemplate()
  private let potionAmount = UIGuidelineLabelTemplate()
  private let crownAmount = UIGuidelineLabelTemplate()
  private let goldAmount = UIGuidelineLabelTemplate()
  private let exit = UIGuidelineButtonTemplate(.close)
  
  init() {
    super.init(frame: CGRectZero)
    self.backgroundColor = .yellow
    
    // MARK: set up subviews
    buyPotion.titleLabel?.textAlignment = .center
    buyCrown.titleLabel?.textAlignment = .center
    buyPotion.addTarget(self, action: #selector(didTapBuyPotion), for: .touchUpInside)
    buyCrown.addTarget(self, action: #selector(didTapBuyCrown), for: .touchUpInside)
    exit.addTarget(self, action: #selector(didTapExit), for: .touchUpInside)

    addSubview(title)
    addSubview(pageDescription)
    addSubview(buyPotion)
    addSubview(buyCrown)
    addSubview(potionAmount)
    addSubview(crownAmount)
    addSubview(goldAmount)
    addSubview(exit)
  
    NSLayoutConstraint.activate([
      title.centerXAnchor.constraint(equalTo: centerXAnchor),
      title.topAnchor.constraint(equalTo: topAnchor, constant: 100),
      
      pageDescription.centerXAnchor.constraint(equalTo: centerXAnchor),
      pageDescription.topAnchor.constraint(equalTo: title.bottomAnchor, constant: UIGuidelineDescriptionGap),
      
      buyCrown.centerXAnchor.constraint(equalTo: centerXAnchor),
      buyCrown.bottomAnchor.constraint(equalTo: potionAmount.topAnchor, constant: -20),
      buyCrown.widthAnchor.constraint(equalToConstant: UIGuidelineButtonWidth),
      
      buyPotion.centerXAnchor.constraint(equalTo: centerXAnchor),
      buyPotion.bottomAnchor.constraint(equalTo: buyCrown.topAnchor, constant: -20),
      buyPotion.widthAnchor.constraint(equalToConstant: UIGuidelineButtonWidth),

      // stack potion and gold in a Stack ??
      goldAmount.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UIGuidelineStatusSide),
      goldAmount.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -UIGuidelineStatusBottom + 30),

      crownAmount.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UIGuidelineStatusSide),
      crownAmount.bottomAnchor.constraint(equalTo: goldAmount.topAnchor, constant: -10),
      
      potionAmount.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UIGuidelineStatusSide),
      potionAmount.bottomAnchor.constraint(equalTo: crownAmount.topAnchor, constant: -10),
      
      exit.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UIGuidelineExitLeading),
      exit.topAnchor.constraint(equalTo: topAnchor, constant: UIGuidelineExitTop),
    ])
  }
  
  func configure(with viewState: ShopViewState) {
    title.text = viewState.titleText
    pageDescription.text = viewState.pageDescriptionText
    buyPotion.configuration = UIGuidelineButtonConfig(title: viewState.buyPotionText, foregroundColor: themeColor)
    buyCrown.configuration = UIGuidelineButtonConfig(title: viewState.buyCrownText, foregroundColor: themeColor)
    potionAmount.text = viewState.potionAmountText
    crownAmount.text = viewState.crownAmountText
    goldAmount.text = viewState.goldAmountText
  }
  
  @objc func didTapBuyPotion() {
    shopViewDelegate?.didTapBuyPotion()
  }

  @objc func didTapBuyCrown() {
    shopViewDelegate?.didTapBuyCrown()
  }

  @objc func didTapExit() {
    shopViewDelegate?.didTapExit()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
