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

  // MARK: Subviews
  private let title = UILabel()
  private let pageDescription = UILabel()
  private let buyPotion = UIButton(type: .system)
  private let buyCrown = UIButton(type: .system)
  private let potionAmount = UILabel()
  private let crownAmount = UILabel()
  private let goldAmount = UILabel()
  private let exit = UIButton(type: .close)
  
  // MARK: UI Constants
  private let themeColor = UIColor.yellow
  
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
    
    // MARK: Layout subviews
    title.translatesAutoresizingMaskIntoConstraints = false
    pageDescription.translatesAutoresizingMaskIntoConstraints = false
    buyPotion.translatesAutoresizingMaskIntoConstraints = false
    buyCrown.translatesAutoresizingMaskIntoConstraints = false
    goldAmount.translatesAutoresizingMaskIntoConstraints = false
    crownAmount.translatesAutoresizingMaskIntoConstraints = false
    potionAmount.translatesAutoresizingMaskIntoConstraints = false
    exit.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate(computedLayoutContraints())
  }
  
  func configure(with viewState: ShopViewState) {
    title.text = viewState.titleText
    pageDescription.text = viewState.pageDescriptionText
    buyPotion.configuration = UIGuidelineButtonConfig(title: viewState.buyPotionText, foregroundColor: themeColor)
    buyPotion.titleLabel?.lineBreakMode = .byWordWrapping
    buyCrown.configuration = UIGuidelineButtonConfig(title: viewState.buyCrownText, foregroundColor: themeColor)
    potionAmount.text = viewState.potionAmountText
    crownAmount.text = viewState.crownAmountText
    goldAmount.text = viewState.goldAmountText
    
    clearConstraints()
    NSLayoutConstraint.activate(computedLayoutContraints())
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
  
  func computedLayoutContraints() -> [NSLayoutConstraint] {
    return [
      title.centerXAnchor.constraint(equalTo: centerXAnchor),
      title.topAnchor.constraint(equalTo: topAnchor, constant: 100),
      title.widthAnchor.constraint(equalToConstant: title.computedWidthAnchor),
      title.heightAnchor.constraint(equalToConstant: title.computedHeightAnchor),
      
      pageDescription.centerXAnchor.constraint(equalTo: centerXAnchor),
      pageDescription.topAnchor.constraint(equalTo: title.bottomAnchor, constant: UIGuidelineDescriptionGap),
      pageDescription.widthAnchor.constraint(equalToConstant: pageDescription.computedWidthAnchor),
      pageDescription.heightAnchor.constraint(equalToConstant: pageDescription.computedHeightAnchor),
      
      buyCrown.centerXAnchor.constraint(equalTo: centerXAnchor),
      buyCrown.bottomAnchor.constraint(equalTo: potionAmount.topAnchor, constant: -20),
      buyCrown.widthAnchor.constraint(equalToConstant: UIGuidelineButtonWidth),
      buyCrown.heightAnchor.constraint(equalToConstant: buyCrown.computedHeightAnchor),
      
      buyPotion.centerXAnchor.constraint(equalTo: centerXAnchor),
      buyPotion.bottomAnchor.constraint(equalTo: buyCrown.topAnchor, constant: -20),
      buyPotion.widthAnchor.constraint(equalToConstant: UIGuidelineButtonWidth),
      buyPotion.heightAnchor.constraint(equalToConstant: buyPotion.computedHeightAnchor),

      // stack potion and gold in a Stack ??
      goldAmount.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UIGuidelineStatusSide),
      goldAmount.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -UIGuidelineStatusBottom + 30),
      goldAmount.widthAnchor.constraint(equalToConstant: goldAmount.computedWidthAnchor),
      goldAmount.heightAnchor.constraint(equalToConstant: goldAmount.computedHeightAnchor),
      
      crownAmount.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UIGuidelineStatusSide),
      crownAmount.bottomAnchor.constraint(equalTo: goldAmount.topAnchor, constant: -10),
      crownAmount.widthAnchor.constraint(equalToConstant: crownAmount.computedWidthAnchor),
      crownAmount.heightAnchor.constraint(equalToConstant: crownAmount.computedHeightAnchor),

      potionAmount.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UIGuidelineStatusSide),
      potionAmount.bottomAnchor.constraint(equalTo: crownAmount.topAnchor, constant: -10),
      potionAmount.widthAnchor.constraint(equalToConstant: potionAmount.computedWidthAnchor),
      potionAmount.heightAnchor.constraint(equalToConstant: potionAmount.computedHeightAnchor),
      
      exit.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UIGuidelineExitLeading),
      exit.topAnchor.constraint(equalTo: topAnchor, constant: UIGuidelineExitTop),
      exit.widthAnchor.constraint(equalToConstant: exit.computedWidthAnchor),
      exit.heightAnchor.constraint(equalToConstant: exit.computedHeightAnchor)
    ]
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
