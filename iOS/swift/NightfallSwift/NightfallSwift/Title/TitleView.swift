//
//  TitleView.swift
//  NightfallSwift
//
//  Created by Jimmy Lee on 1/21/26.
//

import UIKit

protocol StartButtonDelegate {
  func didTapStart()
}

class TitleView : UIView {
  var startButtonDelegate : StartButtonDelegate?
  
  // MARK: Subviews
  private let title: UILabel = {
    let label = UILabel()
    label.textColor = .white
    label.font = UIFont.boldSystemFont(ofSize: 40.0)
    return label
  }()

  private let start = UIButton(type: .custom)
  
  // MARK: Spacing Constants
  private let titleVerticalOffset: CGFloat = -200
  private let startButtonVerticalOffset: CGFloat = 100
  
  init() {
    super.init(frame: CGRectZero)
    backgroundColor = .black

    start.addTarget(self, action: #selector(didTapStart), for: .touchUpInside)
    
    addSubview(title)
    addSubview(start)
    
    title.translatesAutoresizingMaskIntoConstraints = false
    start.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate(computedConstraints())
  }
  
  func computedConstraints() -> [NSLayoutConstraint] {
    return [
      title.centerXAnchor.constraint(equalTo: centerXAnchor),
      title.centerYAnchor.constraint(equalTo: centerYAnchor,
                                     constant: titleVerticalOffset),
      
      start.centerXAnchor.constraint(equalTo: centerXAnchor),
      start.centerYAnchor.constraint(equalTo: centerYAnchor,
                                     constant: startButtonVerticalOffset),
      start.widthAnchor.constraint(equalToConstant: UIGuidelineButtonWidth),
    ]
  }
  
  func startButtonConfig(title: String) -> UIButton.Configuration {
    var config = UIButton.Configuration.filled()
    var attributedString = AttributedString(title)
    attributedString.font = UIGuidelineButtonFont
    config.attributedTitle = attributedString
    config.baseForegroundColor = .black
    config.background.backgroundColor = .blue
    config.cornerStyle = .medium
    config.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 20, bottom: 16, trailing: 20)
    return config
  }
  
  func configure(with viewState: TitleViewState) {
      title.text = viewState.titleText
      start.configuration = startButtonConfig(title: viewState.startText)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  @objc func didTapStart() {
    startButtonDelegate?.didTapStart()
  }
  
}
