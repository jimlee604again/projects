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
  private let title = UILabel()
  private let start = UIButton(type: .custom)
  var startButtonDelegate : StartButtonDelegate?
  
  private let titleVerticalOffset: CGFloat = -200
  private let startButtonVerticalOffset: CGFloat = 100
  
  init() {
    super.init(frame: CGRectZero)

    backgroundColor = .black
    
    title.text = "Nightfall"
    title.textColor = .white
    title.font = UIFont.boldSystemFont(ofSize: 40.0)
    
    start.configuration = startButtonConfig(title: "")
    start.backgroundColor = .blue
    start.layer.cornerRadius = 6.0
    start.addTarget(self, action: #selector(didTapStart), for: .touchUpInside)
    
    addSubview(title)
    addSubview(start)
    
    title.translatesAutoresizingMaskIntoConstraints = false
    start.translatesAutoresizingMaskIntoConstraints = false
  }
  
  func computedConstraints() -> [NSLayoutConstraint] {
    return [
      title.centerXAnchor.constraint(equalTo: centerXAnchor),
      title.centerYAnchor.constraint(equalTo: centerYAnchor,
                                     constant: titleVerticalOffset),
      title.widthAnchor.constraint(equalToConstant: title.computedWidthAnchor),
      title.heightAnchor.constraint(equalToConstant: title.computedHeightAnchor),
      
      start.centerXAnchor.constraint(equalTo: centerXAnchor),
      start.centerYAnchor.constraint(equalTo: centerYAnchor,
                                     constant: startButtonVerticalOffset),
      start.widthAnchor.constraint(equalToConstant: UIGuidelineButtonWidth),
      start.heightAnchor.constraint(equalToConstant: start.computedHeightAnchor)
    ]
  }
  
  func startButtonConfig(title: String) -> UIButton.Configuration {
    var startButtonConfig = UIButton.Configuration.filled()
    var attributedTitle = AttributedString(title)
    attributedTitle.font = UIFont.systemFont(ofSize: 20.0, weight: .bold)
    startButtonConfig.attributedTitle = attributedTitle
    startButtonConfig.baseForegroundColor = .black
    startButtonConfig.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20)
    return startButtonConfig
  }
  
  func configure(with viewState: TitleViewState) {
    title.text = viewState.titleText
    start.configuration = startButtonConfig(title: viewState.startText)
    
    clearConstraints()
    NSLayoutConstraint.activate(computedConstraints())
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  @objc func didTapStart() {
    startButtonDelegate?.didTapStart()
  }
  
}
