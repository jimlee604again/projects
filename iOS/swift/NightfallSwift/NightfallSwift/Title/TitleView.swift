//
//  TitleView.swift
//  NightfallSwift
//
//  Created by Jimmy Lee on 1/21/26.
//

import Foundation
import UIKit

protocol StartButtonDelegate {
  func didTapStart()
}

class TitleView : UIView {
  private let title = UILabel()
  private let start = UIButton(type: .custom)
  var startButtonDelegate : StartButtonDelegate?
  
  init() {
    super.init(frame: CGRectZero)

    self.title.text = "Nightfall"
    self.title.textColor = .white
    self.title.font = UIFont.boldSystemFont(ofSize: 40.0)

    
    self.start.configuration = startButtonConfig(title: "")
    self.start.backgroundColor = .blue
    self.start.layer.cornerRadius = 6.0
    self.start.addTarget(self, action: #selector(didTapStart), for: .touchUpInside)
    self.backgroundColor = .black
    self.addSubview(self.title)
    self.addSubview(self.start)

    let titleSizeThatFits = title.sizeThatFits(self.bounds.size)
    let buttonSizeThatFits = start.sizeThatFits(self.bounds.size)
    
    title.translatesAutoresizingMaskIntoConstraints = false
    start.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate(computedConstraints())
  }
  
  func computedConstraints() -> [NSLayoutConstraint] {
    return [
      title.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      title.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -200),
      title.widthAnchor.constraint(equalToConstant: title.computedWidthAnchor),
      title.heightAnchor.constraint(equalToConstant: title.computedHeightAnchor),
      
      start.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      start.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 100),
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
