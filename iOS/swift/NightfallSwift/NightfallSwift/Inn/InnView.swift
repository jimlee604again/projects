//
//  InnView.swift
//  NightfallSwift
//
//  Created by Jimmy Lee on 2/11/26.
//

import UIKit

protocol InnViewDelegate {
  func didTapStay()
  func didTapExit()
}

class InnView : UIView {
  var innViewDelegate: InnViewDelegate?
  private let themeColor = UIColor.systemPink

  // MARK: Subviews
  private let title = TitleTemplate()
  private let outcomeExplanation = LabelTemplate()
  private let stayButton  = ButtonTemplate()
  private let exitButton = ButtonTemplate(.close)
  private let statusView = PlayerStatusView()

  init() {
    super.init(frame: CGRectZero)

    self.backgroundColor = themeColor

    // MARK: set up subviews
    stayButton.configuration = UIGuidelineButtonConfig(title:"", foregroundColor: themeColor)
    stayButton.addTarget(self, action: #selector(didTapStay), for: .touchUpInside)
    exitButton.addTarget(self, action: #selector(didTapExit), for: .touchUpInside)

    addSubview(title)
    addSubview(outcomeExplanation)
    addSubview(stayButton)
    addSubview(statusView)
    addSubview(exitButton)

    NSLayoutConstraint.activate([
      title.centerXAnchor.constraint(equalTo: centerXAnchor),
      title.topAnchor.constraint(equalTo: topAnchor, constant: UIGuidelineTitleTopInset),

      outcomeExplanation.centerXAnchor.constraint(equalTo: centerXAnchor),
      outcomeExplanation.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 30),

      stayButton.centerXAnchor.constraint(equalTo: centerXAnchor),
      stayButton.bottomAnchor.constraint(equalTo: statusView.topAnchor, constant: -UIGuidelineButtonToStatusSpacing),
      stayButton.widthAnchor.constraint(equalToConstant: UIGuidelineButtonWidth),

      exitButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UIGuidelineExitLeading),
      exitButton.topAnchor.constraint(equalTo: topAnchor, constant: UIGuidelineExitTop),

      statusView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UIGuidelineStatusSide),
      statusView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -UIGuidelineStatusBottom)
    ])
  }

  func configureWith(_ viewState: InnViewState) {
    title.text = viewState.title
    outcomeExplanation.text = viewState.outcomeExplanation
    statusView.configure(hpText: viewState.hpText, goldText: viewState.goldText)
    stayButton.configuration = stayButtonConfig(title: viewState.stayButtonText)
  }

  func stayButtonConfig(title: String) -> UIButton.Configuration {
    var stayButtonConfig = UIButton.Configuration.filled()
    var attributedTitle = AttributedString(title)
    attributedTitle.font = UIFont.systemFont(ofSize: 20.0, weight: .bold)
    stayButtonConfig.attributedTitle = attributedTitle
    stayButtonConfig.baseForegroundColor = themeColor
    stayButtonConfig.background.backgroundColor = .black
    stayButtonConfig.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 20, bottom: 16, trailing: 20)
    return stayButtonConfig
  }

  @objc func didTapStay() {
    innViewDelegate?.didTapStay()
  }

  @objc func didTapExit() {
    innViewDelegate?.didTapExit()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
