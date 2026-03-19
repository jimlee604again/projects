//
//  BattleView.swift
//  NightfallSwift
//
//  Created by Jimmy Lee on 3/12/26.
//

import UIKit

protocol BattleViewDelegate: AnyObject {
  func didTapExit()
  func didTapBattle()
}

final class BattleView: UIView {
  weak var delegate: BattleViewDelegate?
  
  // MARK: - Subviews
  private let title: UILabel = {
    let label = UILabel()
    label.font = UIGuidelineTitleFont
    label.textAlignment = .center
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private let outcomeExplanation: UILabel = {
    let label = UILabel()
    label.textAlignment = .center
    label.numberOfLines = 0
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private let battle: UIButton = {
    let button = UIButton(type: .custom)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  private let exit: UIButton = {
    let button = UIButton(type: .close)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  private let hpLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private let goldLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private let themeColor: UIColor = .red
  
  // MARK: - Init
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    backgroundColor = themeColor
    
    battle.addTarget(self, action: #selector(didTapBattle), for: .touchUpInside)
    exit.addTarget(self, action: #selector(didTapExit), for: .touchUpInside)
    
    addSubview(title)
    addSubview(outcomeExplanation)
    addSubview(battle)
    addSubview(hpLabel)
    addSubview(goldLabel)
    addSubview(exit)
    
    NSLayoutConstraint.activate([
      title.centerXAnchor.constraint(equalTo: centerXAnchor),
      title.topAnchor.constraint(equalTo: topAnchor, constant: UIGuidelineTitleTopInset),
      
      outcomeExplanation.centerXAnchor.constraint(equalTo: centerXAnchor),
      outcomeExplanation.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 20),
      outcomeExplanation.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 24),
      outcomeExplanation.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -24),
      
      hpLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UIGuidelineStatusSide),
      hpLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -UIGuidelineStatusBottom),
      
      goldLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UIGuidelineStatusSide),
      goldLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -UIGuidelineStatusBottom + 30),
      
      battle.centerXAnchor.constraint(equalTo: centerXAnchor),
      battle.bottomAnchor.constraint(equalTo: hpLabel.topAnchor, constant: -50),
      battle.widthAnchor.constraint(equalToConstant: UIGuidelineButtonWidth),
      
      exit.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UIGuidelineExitLeading),
      exit.topAnchor.constraint(equalTo: topAnchor, constant: UIGuidelineExitTop)
    ])
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configure(_ state: BattleViewState) {
    title.text = state.titleText
    outcomeExplanation.text = state.outcomeExplanationText
    hpLabel.text = state.hpLabelText
    goldLabel.text = state.goldLabelText
    battle.configuration = UIGuidelineButtonConfig(
      title: state.battleButtonText,
      foregroundColor: themeColor
    )
  }
  
  @objc private func didTapBattle() {
    delegate?.didTapBattle()
  }
  
  @objc private func didTapExit() {
    delegate?.didTapExit()
  }
}
