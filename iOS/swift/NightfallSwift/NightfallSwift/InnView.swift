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

  // MARK: Subviews
  private let title = UILabel()
  private let outcomeExplanation = UILabel()
  private let stayButton = UIButton(type: .system)
  private let exitButton = UIButton(type: .close)

  // MARK: UI
  private let themeColor = UIColor.systemPink

  init() {
    super.init(frame: CGRectZero)

    self.backgroundColor = themeColor

    // MARK: set up subviews
    title.font = UIGuidelineTitleFont
    stayButton.configuration = UIGuidelineButtonConfig(title:"", foregroundColor: themeColor)
    stayButton.addTarget(self, action: #selector(didTapStay), for: .touchUpInside)
    exitButton.addTarget(self, action: #selector(didTapExit), for: .touchUpInside)

    addSubview(title)
    addSubview(outcomeExplanation)
    addSubview(stayButton)
    addSubview(exitButton)

    // MARK: layout subviews
    title.translatesAutoresizingMaskIntoConstraints = false
    outcomeExplanation.translatesAutoresizingMaskIntoConstraints = false
    stayButton.translatesAutoresizingMaskIntoConstraints = false
    exitButton.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate(computeLayoutConstraints())
  }
  
  func computeLayoutConstraints() -> [NSLayoutConstraint] {
    return [
      title.centerXAnchor.constraint(equalTo: centerXAnchor),
      title.topAnchor.constraint(equalTo: topAnchor, constant: UIGuidelineTitleTopInset),
      title.widthAnchor.constraint(equalToConstant: title.computedWidthAnchor),
      title.heightAnchor.constraint(equalToConstant: title.computedHeightAnchor),
      
      outcomeExplanation.centerXAnchor.constraint(equalTo: centerXAnchor),
      outcomeExplanation.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 30),
      outcomeExplanation.widthAnchor.constraint(equalToConstant: outcomeExplanation.computedWidthAnchor),
      outcomeExplanation.heightAnchor.constraint(equalToConstant: outcomeExplanation.computedHeightAnchor),

      stayButton.centerXAnchor.constraint(equalTo: centerXAnchor),
      stayButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -100),
      stayButton.widthAnchor.constraint(equalToConstant: UIGuidelineButtonWidth),
      stayButton.heightAnchor.constraint(equalToConstant: stayButton.computedHeightAnchor),

      exitButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UIGuidelineExitLeading),
      exitButton.topAnchor.constraint(equalTo: topAnchor, constant: UIGuidelineExitTop),
      exitButton.widthAnchor.constraint(equalToConstant: exitButton.computedWidthAnchor),
      exitButton.heightAnchor.constraint(equalToConstant: exitButton.computedHeightAnchor)
    ]
  }

  func configureWith(_ viewState: InnViewState) {
    title.text = viewState.title
    outcomeExplanation.text = viewState.outcomeExplanation
    stayButton.configuration = stayButtonConfig(title: viewState.stayButtonText)
    clearConstraints()
    NSLayoutConstraint.activate(computeLayoutConstraints())
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
