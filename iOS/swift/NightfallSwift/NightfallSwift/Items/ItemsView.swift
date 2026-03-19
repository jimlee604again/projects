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
  
  // add hp and gold amount
  
  private let exit = UIGuidelineButtonTemplate(.close)
  private let usePotion = UIGuidelineButtonTemplate()
  
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

    NSLayoutConstraint.activate([
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
    ])
  }
  
  func configure(with viewState: ItemsViewState) {
    title.text = viewState.title
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
