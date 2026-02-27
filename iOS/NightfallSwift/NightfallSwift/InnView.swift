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
  
  init(innViewModel: InnViewModel) {
    self.innViewModel = innViewModel
    
    super.init(frame: CGRectZero)

    self.backgroundColor = .yellow
    
    // MARK: set up subvies
    titleView.text = innViewModel.titleText
    stayButton.setTitle(innViewModel.stayButtonText, for: .normal)
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
      
      exitButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UIGuidelineExitLeadingConstant),
      exitButton.topAnchor.constraint(equalTo: topAnchor, constant: UIGuidelineExitTopConstant)
    ])
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
