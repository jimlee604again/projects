//
//  ItemsView.swift
//  NightfallSwift
//
//  Created by Jimmy Lee on 3/11/26.
//

import UIKit

protocol ItemsViewDelegate {
  func didTapExit()
}

class ItemsView : UIView {
  private let itemsViewModel: ItemsViewModel
  var itemsViewDelegate: ItemsViewDelegate?

  // MARK: Subviews
  private let titleView = UILabel()
  private let potionsCountLabel = UILabel()
  private let crownsCountLabel = UILabel()
  private let exitButton = UIButton(type: .close)
  var potionsCountSize : CGSize {
    potionsCountLabel.sizeThatFits(self.bounds.size)
  }
  var crownsCountSize : CGSize {
    crownsCountLabel.sizeThatFits(self.bounds.size)
  }
  
  // MARK: UI
  private let themeColor = UIColor.green
  
  init(itemsViewModel: ItemsViewModel) {
    self.itemsViewModel = itemsViewModel
    
    super.init(frame: CGRectZero)

    self.backgroundColor = themeColor
    
    // MARK: set up subviewss
    titleView.text = itemsViewModel.titleText
    titleView.font = UIFont.preferredFont(forTextStyle: .largeTitle)
    potionsCountLabel.text = itemsViewModel.potionsCountText
    crownsCountLabel.text = itemsViewModel.crownsCountText
    exitButton.addTarget(self, action: #selector(didTapExit), for: .touchUpInside)

    addSubview(titleView)
    addSubview(potionsCountLabel)
    addSubview(crownsCountLabel)
    addSubview(exitButton)
    
    // MARK: layout subviews
    titleView.translatesAutoresizingMaskIntoConstraints = false
    potionsCountLabel.translatesAutoresizingMaskIntoConstraints = false
    crownsCountLabel.translatesAutoresizingMaskIntoConstraints = false
    exitButton.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      titleView.centerXAnchor.constraint(equalTo: centerXAnchor),
      titleView.topAnchor.constraint(equalTo: topAnchor, constant: 100),
      
      potionsCountLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
      potionsCountLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -240),
      
      crownsCountLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
      crownsCountLabel.topAnchor.constraint(equalTo: potionsCountLabel.bottomAnchor, constant: 10),
      
      exitButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UIGuidelineExitLeading),
      exitButton.topAnchor.constraint(equalTo: topAnchor, constant: UIGuidelineExitTop)
    ])
  }

  @objc func didTapExit() {
    itemsViewDelegate?.didTapExit()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
