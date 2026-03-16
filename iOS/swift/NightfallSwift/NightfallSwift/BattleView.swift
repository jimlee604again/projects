//
//  BattleView.swift
//  NightfallSwift
//
//  Created by Jimmy Lee on 3/12/26.
//

import UIKit

protocol BattleViewDelegate {
  func didTapExit()
  func didTapBattle()
}

class BattleView : UIView {
  private let title : UILabel = {
    let title = UILabel()
    title.font = UIGuidelineTitleFont
    title.textAlignment = .center
    return title
  }()
  private let outcomeExplanation : UILabel = {
    let outcomeExplanation = UILabel()
//    outcomeExplanation.font = UIGuidelineBodyFont
    outcomeExplanation.textAlignment = .center
    return outcomeExplanation
  }()
  private let battleButton: UIButton = {
    let battleButton = UIButton()
    // make changes here
    return battleButton
  }()
  private let exitButton = UIButton(type: .close)
  
  private let hpLabel = UILabel()
  private let goldLabel = UILabel()
  var delegate: BattleViewDelegate?
  
  private let themeColor: UIColor = .red
  
  init() {
    super.init(frame: CGRectZero)

    self.backgroundColor = themeColor
    battleButton.addTarget(self, action: #selector(didTapBattle), for: .touchUpInside)
    exitButton.addTarget(self, action:  #selector(didTapExit), for: .touchUpInside)

    self.addSubview(title)
    self.addSubview(outcomeExplanation)
    self.addSubview(battleButton)
    self.addSubview(hpLabel)
    self.addSubview(goldLabel)
    self.addSubview(exitButton)

    title.translatesAutoresizingMaskIntoConstraints = false
    outcomeExplanation.translatesAutoresizingMaskIntoConstraints = false
    battleButton.translatesAutoresizingMaskIntoConstraints = false
    hpLabel.translatesAutoresizingMaskIntoConstraints = false
    goldLabel.translatesAutoresizingMaskIntoConstraints = false
    exitButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate(computedConstraints())
  }

  @objc
  func didTapBattle() {
    delegate?.didTapBattle()
  }
  
  @objc
  func didTapExit() {
    delegate?.didTapExit()
  }
  
  func configure(_ battleViewState: BattleViewState) {
    title.text = battleViewState.titleText
    outcomeExplanation.text = battleViewState.outcomeExplanationText
    battleButton.configuration = UIGuidelineButtonConfig(title: battleViewState.battleButtonText, foregroundColor: themeColor)
    hpLabel.text = battleViewState.hpLabelText
    hpLabel.sizeToFit()
    goldLabel.text = battleViewState.goldLabelText
    goldLabel.sizeToFit()
    
    clearConstraints()
    NSLayoutConstraint.activate(computedConstraints())
  }
  
  func computedConstraints() -> [NSLayoutConstraint] {
    return [
      title.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      title.topAnchor.constraint(equalTo: self.topAnchor, constant: UIGuidelineTitleTopInset),
      title.widthAnchor.constraint(equalToConstant: title.computedWidthAnchor),
      title.heightAnchor.constraint(equalToConstant: title.computedHeightAnchor),
      
      outcomeExplanation.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      outcomeExplanation.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 20),
      outcomeExplanation.widthAnchor.constraint(equalToConstant: outcomeExplanation.computedWidthAnchor),
      outcomeExplanation.heightAnchor.constraint(equalToConstant: outcomeExplanation.computedHeightAnchor),
      
      // make this a stack for HP and Gold
      hpLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: UIGuidelineStatusSide),
      hpLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -UIGuidelineStatusBottom),
      hpLabel.widthAnchor.constraint(equalToConstant: hpLabel.computedWidthAnchor),
      hpLabel.heightAnchor.constraint(equalToConstant: hpLabel.computedHeightAnchor),

      goldLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: UIGuidelineStatusSide),
      goldLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -UIGuidelineStatusBottom + 30),
      goldLabel.widthAnchor.constraint(equalToConstant: goldLabel.computedWidthAnchor),
      goldLabel.heightAnchor.constraint(equalToConstant: goldLabel.computedHeightAnchor),
      
      battleButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      battleButton.bottomAnchor.constraint(equalTo: self.hpLabel.topAnchor, constant: -50),
      battleButton.widthAnchor.constraint(equalToConstant: UIGuidelineButtonWidth),
      battleButton.heightAnchor.constraint(equalToConstant: battleButton.computedHeightAnchor),

      exitButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UIGuidelineExitLeading),
      exitButton.topAnchor.constraint(equalTo: topAnchor, constant: UIGuidelineExitTop),
      exitButton.widthAnchor.constraint(equalToConstant: exitButton.computedWidthAnchor),
      exitButton.heightAnchor.constraint(equalToConstant: exitButton.computedHeightAnchor)
    ]
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
