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
  private let potionCountLabel = UILabel()
  private let goldLabel = UILabel()
  private let exitButton = UIButton(type: .close)
  var titleLabelSize : CGSize {
    return titleLabel.sizeThatFits(self.bounds.size)
  }
  var buyPotionButtonSize : CGSize {
    return buyPotionButton.sizeThatFits(self.bounds.size)
  }
  var buyMagicCrownButtonSize : CGSize {
    return buyMagicCrownButton.sizeThatFits(self.bounds.size)
  }
  var goldLabelSize : CGSize {
    return goldLabel.sizeThatFits(self.bounds.size)
  }
  var potionCountLabelSize : CGSize {
    return potionCountLabel.sizeThatFits(self.bounds.size)
  }
  var exitButtonSize : CGSize {
    return exitButton.sizeThatFits(self.bounds.size)
  }
  
  // MARK: UI Constants
  private let themeColor = UIColor.yellow
  
  init(shopViewModel: ShopViewModel) {
    self.shopViewModel = shopViewModel
    
    super.init(frame: CGRectZero)

    self.backgroundColor = .yellow
    
    // MARK: set up subviews
    titleLabel.text = shopViewModel.titleText
    buyPotionButton.configuration = UIGuidelineButtonConfig(title: shopViewModel.buyPotionButtonText, foregroundColor: themeColor)
    buyPotionButton.titleLabel?.textAlignment = .center
    buyPotionButton.addTarget(self, action: #selector(didTapBuyPotion), for: .touchUpInside)
    buyMagicCrownButton.configuration = UIGuidelineButtonConfig(title: shopViewModel.buyMagicCrownButtonText, foregroundColor: themeColor)
    buyMagicCrownButton.addTarget(self, action: #selector(didTapBuyMagicCrown), for: .touchUpInside)
    buyMagicCrownButton.titleLabel?.textAlignment = .center
    goldLabel.text = shopViewModel.goldText
    potionCountLabel.text = shopViewModel.potionCountText
    exitButton.addTarget(self, action: #selector(didTapExit), for: .touchUpInside)

    addSubview(titleLabel)
    addSubview(buyPotionButton)
    addSubview(buyMagicCrownButton)
    addSubview(potionCountLabel)
    addSubview(goldLabel)
    addSubview(exitButton)
    
    // MARK: Layout subviews
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    buyPotionButton.translatesAutoresizingMaskIntoConstraints = false
    buyMagicCrownButton.translatesAutoresizingMaskIntoConstraints = false
    goldLabel.translatesAutoresizingMaskIntoConstraints = false
    potionCountLabel.translatesAutoresizingMaskIntoConstraints = false
    exitButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate(computedLayoutContraints())
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
  
  func dataDidChange() {
    setNeedsUpdateProperties()
    potionCountLabel.attributedText = NSAttributedString(string: shopViewModel.potionCountText)
    goldLabel.attributedText = NSAttributedString(string: shopViewModel.goldText)
    clearConstraints()
    NSLayoutConstraint.activate(computedLayoutContraints())
  }
  
  override func updateProperties() {
    super.updateProperties()
  }
  
  func computedLayoutContraints() -> [NSLayoutConstraint] {
    return [
      titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
      titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 100),
      titleLabel.widthAnchor.constraint(equalToConstant: titleLabelSize.width),
      titleLabel.heightAnchor.constraint(equalToConstant: titleLabelSize.height),
      
      buyPotionButton.centerXAnchor.constraint(equalTo: centerXAnchor),
      buyPotionButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -240),
      buyPotionButton.widthAnchor.constraint(equalToConstant: UIGuidelineButtonWidth),
      buyPotionButton.heightAnchor.constraint(equalToConstant: buyPotionButtonSize.height),
      
      buyMagicCrownButton.centerXAnchor.constraint(equalTo: centerXAnchor),
      buyMagicCrownButton.topAnchor.constraint(equalTo: buyPotionButton.bottomAnchor, constant: 10),
      buyMagicCrownButton.widthAnchor.constraint(equalToConstant: UIGuidelineButtonWidth),
      buyMagicCrownButton.heightAnchor.constraint(equalToConstant: buyMagicCrownButtonSize.height),
      
      potionCountLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: UIGuidelineStatusSide),
      potionCountLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -UIGuidelineStatusBottom),
      potionCountLabel.widthAnchor.constraint(equalToConstant: potionCountLabelSize.width),
      potionCountLabel.heightAnchor.constraint(equalToConstant: potionCountLabelSize.height),
      
      goldLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: UIGuidelineStatusSide),
      goldLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -UIGuidelineStatusBottom + 30),
      goldLabel.widthAnchor.constraint(equalToConstant: goldLabelSize.width),
      goldLabel.heightAnchor.constraint(equalToConstant: goldLabelSize.height),
      
      exitButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UIGuidelineExitLeading),
      exitButton.topAnchor.constraint(equalTo: topAnchor, constant: UIGuidelineExitTop),
      exitButton.widthAnchor.constraint(equalToConstant: exitButtonSize.width),
      exitButton.heightAnchor.constraint(equalToConstant: exitButtonSize.height)
    ]
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
