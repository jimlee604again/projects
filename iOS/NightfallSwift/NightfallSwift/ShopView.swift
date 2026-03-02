//
//  ShopView.swift
//  NightfallSwift
//
//  Created by Jimmy Lee on 3/1/26.
//

import UIKit

protocol ShopViewDelegate {
  func didTapBuyPotion()
  func didTapBuyMagicCrown()
  func didTapExit()
}

class ShopView : UIView {
  private let shopViewModel: ShopViewModel
  var shopViewDelegate: ShopViewDelegate?

  // MARK: Subviews
  private let titleLabel = UILabel()
  private let buyPotionButton = UIButton(type: .system)
  private let buyMagicCrownButton = UIButton(type: .system)
  private let goldLabel = UILabel()
  private let exitButton = UIButton(type: .close)
  var goldLabelSize : CGSize {
    return goldLabel.sizeThatFits(self.bounds.size)
  }
  
  init(shopViewModel: ShopViewModel) {
    self.shopViewModel = shopViewModel
    
    super.init(frame: CGRectZero)

    self.backgroundColor = .yellow
    
    // MARK: set up subviews
    titleLabel.text = shopViewModel.titleText
    buyPotionButton.setTitle(shopViewModel.buyPotionButtonText, for: .normal)
    buyPotionButton.addTarget(self, action: #selector(didTapBuyPotion), for: .touchUpInside)
    buyMagicCrownButton.setTitle(shopViewModel.buyMagicCrownButtonText, for: .normal)
    buyMagicCrownButton.addTarget(self, action: #selector(didTapBuyMagicCrown), for: .touchUpInside)
    goldLabel.text = shopViewModel.goldText
    exitButton.addTarget(self, action: #selector(didTapExit), for: .touchUpInside)

    addSubview(titleLabel)
    addSubview(buyPotionButton)
    addSubview(buyMagicCrownButton)
    addSubview(goldLabel)
    addSubview(exitButton)
    
    // MARK: layout subviews
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    buyPotionButton.translatesAutoresizingMaskIntoConstraints = false
    buyMagicCrownButton.translatesAutoresizingMaskIntoConstraints = false
    goldLabel.translatesAutoresizingMaskIntoConstraints = false
    exitButton.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
      titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 100),
      
      buyPotionButton.centerXAnchor.constraint(equalTo: centerXAnchor),
      buyPotionButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -200),
      
      buyMagicCrownButton.centerXAnchor.constraint(equalTo: centerXAnchor),
      buyMagicCrownButton.topAnchor.constraint(equalTo: buyPotionButton.bottomAnchor, constant: 6),
      
      goldLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: UIGuidelineStatusSide),
      goldLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -UIGuidelineStatusBottom + 30),
      goldLabel.widthAnchor.constraint(equalToConstant: goldLabelSize.width),
      goldLabel.heightAnchor.constraint(equalToConstant: goldLabelSize.height),
      
      exitButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UIGuidelineExitLeading),
      exitButton.topAnchor.constraint(equalTo: topAnchor, constant: UIGuidelineExitTop)
    ])
  }
  
  @objc func didTapBuyPotion() {
    shopViewDelegate?.didTapBuyPotion()
  }

  @objc func didTapBuyMagicCrown() {
    shopViewDelegate?.didTapBuyMagicCrown()
  }

  @objc func didTapExit() {
    shopViewDelegate?.didTapExit()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
