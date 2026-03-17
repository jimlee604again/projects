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

  // MARK: Subviews
  private let title = UILabel()
  private let pageDescription = UILabel()
  private let potionsCount = UILabel()
  private let crownsCount = UILabel()
  private let exit = UIButton(type: .close)
  private let usePotion = UIButton(type: .custom)
  var potionsCountSize : CGSize {
    potionsCount.sizeThatFits(self.bounds.size)
  }
  var crownsCountSize : CGSize {
    crownsCount.sizeThatFits(self.bounds.size)
  }
  
  // MARK: UI
  private let themeColor = UIColor.green
  
  init() {
    super.init(frame: CGRectZero)

    self.backgroundColor = themeColor
    
    // MARK: set up subviews
    title.font = UIFont.preferredFont(forTextStyle: .largeTitle)
    exit.addTarget(self, action: #selector(didTapExit), for: .touchUpInside)
    usePotion.addTarget(self, action: #selector(didTapUsePotion), for: .touchUpInside)
    
    addSubview(title)
    addSubview(usePotion)
    addSubview(potionsCount)
    addSubview(crownsCount)
    addSubview(exit)
    
    // MARK: layout subviews
    title.translatesAutoresizingMaskIntoConstraints = false
    usePotion.translatesAutoresizingMaskIntoConstraints = false
    potionsCount.translatesAutoresizingMaskIntoConstraints = false
    crownsCount.translatesAutoresizingMaskIntoConstraints = false
    exit.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate(computedConstraints())
  }
  
  func computedConstraints () -> [NSLayoutConstraint] {
    return [
      title.centerXAnchor.constraint(equalTo: centerXAnchor),
      title.topAnchor.constraint(equalTo: topAnchor, constant: 100),
      
      potionsCount.centerXAnchor.constraint(equalTo: centerXAnchor),
      potionsCount.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -140),
      
      crownsCount.centerXAnchor.constraint(equalTo: centerXAnchor),
      crownsCount.topAnchor.constraint(equalTo: potionsCount.bottomAnchor, constant: 10),
      
      exit.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UIGuidelineExitLeading),
      exit.topAnchor.constraint(equalTo: topAnchor, constant: UIGuidelineExitTop),
      
      usePotion.centerXAnchor.constraint(equalTo: centerXAnchor),
      usePotion.bottomAnchor.constraint(equalTo: potionsCount.topAnchor, constant: -20),
      usePotion.widthAnchor.constraint(equalToConstant: usePotion.computedWidthAnchor),
      usePotion.heightAnchor.constraint(equalToConstant: usePotion.computedHeightAnchor)
    ]
  }
  
  func configure(with viewState: ItemsViewState) {
    title.text = viewState.title
    pageDescription.text = viewState.pageDescription
    potionsCount.text = viewState.potionAmountText
    crownsCount.text = viewState.crownAmountText
    usePotion.configuration = UIGuidelineButtonConfig(title: viewState.usePotionText, foregroundColor: themeColor)
    
    clearConstraints()
    NSLayoutConstraint.activate(computedConstraints())
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
