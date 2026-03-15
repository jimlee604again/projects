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
  private let titleView = UILabel()
  private let stayButton = UIButton(type: .system)
  private let exitButton = UIButton(type: .close)

  // MARK: UI
  private let themeColor = UIColor.systemPink

  init() {
    super.init(frame: CGRectZero)

    self.backgroundColor = themeColor

    // MARK: set up subviews
    titleView.text = ""
    titleView.font = UIGuidelineTitleFont
    stayButton.configuration = UIGuidelineButtonConfig(title:"", foregroundColor: themeColor)
    stayButton.addTarget(self, action: #selector(didTapStay), for: .touchUpInside)
    exitButton.addTarget(self, action: #selector(didTapExit), for: .touchUpInside)

    addSubview(titleView)
    addSubview(stayButton)
    addSubview(exitButton)

    // MARK: layout subviews
    titleView.translatesAutoresizingMaskIntoConstraints = false
    stayButton.translatesAutoresizingMaskIntoConstraints = false
    exitButton.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate(computeLayoutConstraints())
  }
  
  func computeLayoutConstraints() -> [NSLayoutConstraint] {
    return [
      titleView.centerXAnchor.constraint(equalTo: centerXAnchor),
      titleView.topAnchor.constraint(equalTo: topAnchor, constant: UIGuidelineTitleTopInset),

      stayButton.centerXAnchor.constraint(equalTo: centerXAnchor),
      stayButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -100),
      stayButton.widthAnchor.constraint(equalToConstant: UIGuidelineButtonWidth),

      exitButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UIGuidelineExitLeading),
      exitButton.topAnchor.constraint(equalTo: topAnchor, constant: UIGuidelineExitTop)
    ]
  }

  func configureWith(_ viewState: InnViewState) {
    titleView.text = viewState.title
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
