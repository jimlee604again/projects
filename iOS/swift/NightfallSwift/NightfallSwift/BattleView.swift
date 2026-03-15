//
//  BattleView.swift
//  NightfallSwift
//
//  Created by Jimmy Lee on 3/12/26.
//

import UIKit

class BattleView : UIView {
  private let battleViewModel : BattleViewModel
  private let titleText = UILabel()
  
  init(battleViewModel : BattleViewModel) {
    self.battleViewModel = battleViewModel
    super.init(frame: CGRectZero)

    self.backgroundColor = .red
    
    titleText.text = battleViewModel.titleText
    titleText.font = UIGuidelineTitleFont
    titleText.textAlignment = .center
    self.addSubview(titleText)
    titleText.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      titleText.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      titleText.topAnchor.constraint(equalTo: self.topAnchor, constant: UIGuidelineTitleTopInset)
    ])
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
