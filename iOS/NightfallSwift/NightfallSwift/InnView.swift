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
  private let innViewModel: InnViewModel
  var innViewDelegate: InnViewDelegate?

  // MARK: Subviews
  private let titleView = UILabel()
  private let stayButton = UIButton(type: .system)
  private let exitButton = UIButton(type: .close)
  
  // MARK: UI
  private let themeColor = UIColor.systemPink
  
  init(innViewModel: InnViewModel) {
    self.innViewModel = innViewModel
    
    super.init(frame: CGRectZero)

    self.backgroundColor = themeColor
    
    // MARK: set up subviewss
    titleView.text = innViewModel.titleText
    titleView.font = UIFont.preferredFont(forTextStyle: .largeTitle)
    stayButton.configuration = UIGuidelineButtonConfig(title: innViewModel.stayButtonText, foregroundColor: themeColor)
    stayButton.addTarget(self, action: #selector(didTapStay), for: .touchUpInside)
    exitButton.addTarget(self, action: #selector(didTapExit), for: .touchUpInside)

    addSubview(titleView)
    addSubview(stayButton)
    addSubview(exitButton)
    
    // MARK: layout subviews
    titleView.translatesAutoresizingMaskIntoConstraints = false
    stayButton.translatesAutoresizingMaskIntoConstraints = false
    exitButton.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      titleView.centerXAnchor.constraint(equalTo: centerXAnchor),
      titleView.topAnchor.constraint(equalTo: topAnchor, constant: 100),
      
      stayButton.centerXAnchor.constraint(equalTo: centerXAnchor),
      stayButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -100),
      stayButton.widthAnchor.constraint(equalToConstant: UIGuidelineButtonWidth),
      
      exitButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UIGuidelineExitLeading),
      exitButton.topAnchor.constraint(equalTo: topAnchor, constant: UIGuidelineExitTop)
    ])
  }
  
  func stayButtonConfig() -> UIButton.Configuration {
    var stayButtonConfig = UIButton.Configuration.filled()
    var attributedTitle = AttributedString("Stay")
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
