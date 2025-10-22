//
//  TimerToolbeltView.swift
//  LifeHack
//
//  Created by Jimmy Lee on 3/23/24.
//

import Foundation
import UIKit

class TimerToolbeltView: UIView {
  var pausePlayButton: UIButton
  var stopButton: UIButton
  var timeManager: TimeManager

  let buttonSize = 40.0
  
  init(frame: CGRect, timeManager: TimeManager) {
    self.timeManager = timeManager
    pausePlayButton = UIButton()
    stopButton = UIButton()

    super.init(frame: frame)
    
    backgroundColor = .black
    
    addSubview(pausePlayButton)
    addSubview(stopButton)
    
    pausePlayButton.titleLabel?.font = UIFont(name: "ArialRoundedMTBold", size: buttonSize)
    pausePlayButton.setTitle("⏸︎", for: .normal)
    pausePlayButton.setTitleColor(.white, for: .normal)
    pausePlayButton.addTarget(self, action: #selector(didTapPausePlay), for: .touchUpInside)
    
    stopButton.titleLabel?.font = UIFont(name: "ArialRoundedMTBold", size: buttonSize)
    stopButton.setTitle("⏹︎", for: .normal)
    stopButton.setTitleColor(.white, for: .normal)
    stopButton.addTarget(self, action: #selector(didTapStop), for: .touchUpInside)
    
    clipsToBounds = true
    layer.cornerRadius = 10.0
    layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func layoutSubviews() {
    let padding = 20.0
    pausePlayButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      pausePlayButton.centerYAnchor.constraint(equalTo: centerYAnchor),
      pausePlayButton.leftAnchor.constraint(equalTo: leftAnchor, constant: padding),
      pausePlayButton.heightAnchor.constraint(equalToConstant: buttonSize),
      pausePlayButton.widthAnchor.constraint(equalToConstant: buttonSize)
    ])
    
    stopButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      stopButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
      stopButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -padding),
      stopButton.heightAnchor.constraint(equalToConstant: buttonSize),
      stopButton.widthAnchor.constraint(equalToConstant: buttonSize)
    ])
  }
  
  @objc func didTapPausePlay() {
    timeManager.togglePauseTimer()
    if timeManager.isPaused() {
      pausePlayButton.setTitle("⏵︎", for: .normal)
    } else {
      pausePlayButton.setTitle("⏸︎", for: .normal)
    }
  }
  
  @objc func didTapStop() {
    timeManager.cancelTimer()
    pausePlayButton.setTitle("⏵︎", for: .normal)
  }
}
