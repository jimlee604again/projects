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
  private let themeColor: UIColor = .red

  // MARK: - Subviews
  private let title = TitleTemplate()
  private let outcomeExplanation = LabelTemplate()
  private let battle = ButtonTemplate()
  private let exit = ButtonTemplate(.close)
  private let statusView = PlayerStatusView()

  // MARK: - Init
  override init(frame: CGRect) {
    super.init(frame: frame)

    backgroundColor = themeColor

    battle.addTarget(self, action: #selector(didTapBattle), for: .touchUpInside)
    exit.addTarget(self, action: #selector(didTapExit), for: .touchUpInside)

    addSubview(title)
    addSubview(outcomeExplanation)
    addSubview(battle)
    addSubview(statusView)
    addSubview(exit)

    NSLayoutConstraint.activate([
      title.centerXAnchor.constraint(equalTo: centerXAnchor),
      title.topAnchor.constraint(equalTo: topAnchor, constant: UIGuidelineTitleTopInset),

      outcomeExplanation.centerXAnchor.constraint(equalTo: centerXAnchor),
      outcomeExplanation.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 20),
      outcomeExplanation.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 24),
      outcomeExplanation.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -24),

      statusView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UIGuidelineStatusSide),
      statusView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -UIGuidelineStatusBottom),

      battle.centerXAnchor.constraint(equalTo: centerXAnchor),
      battle.bottomAnchor.constraint(equalTo: statusView.topAnchor, constant: -50),
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
    statusView.configure(hpText: state.hpLabelText, goldText: state.goldLabelText)
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
