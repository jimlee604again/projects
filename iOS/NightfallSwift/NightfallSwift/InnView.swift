//
//  InnView.swift
//  NightfallSwift
//
//  Created by Jimmy Lee on 2/11/26.
//

import UIKit

protocol InnViewDelegate {
  func didTapStay()
}

class InnView : UIView {
  private let innViewModel: InnViewModel
  var innViewDelegate: InnViewDelegate?

  // MARK: Subviews
  private let titleView = UILabel()
  private let stayButton = UIButton(type: .system)
  
  init(innViewModel: InnViewModel) {
    self.innViewModel = innViewModel
    
    super.init(frame: CGRectZero)

    self.backgroundColor = .yellow
    titleView.text = innViewModel.titleText
    stayButton.setTitle(innViewModel.stayButtonText, for: .normal)
    stayButton.addTarget(self, action: #selector(didTapStay), for: .touchUpInside)

    addSubview(titleView)
    addSubview(stayButton)
    
    titleView.translatesAutoresizingMaskIntoConstraints = false
    stayButton.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      titleView.centerXAnchor.constraint(equalTo: centerXAnchor),
      titleView.topAnchor.constraint(equalTo: topAnchor, constant: 100),
      
      stayButton.centerXAnchor.constraint(equalTo: centerXAnchor),
      stayButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -100)
    ])
  }
  
  @objc
  func didTapStay() {
    innViewDelegate?.didTapStay()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
