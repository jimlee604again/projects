//
//  ToolbeltView.swift
//  LifeHack
//
//  Created by Jimmy Lee on 11/27/23.
//

import Foundation
import UIKit

enum TimeManagerState {
  case uninitialized, shown, hidden
}

protocol TimeManager {
  func initializeTime()
  func displayTime()
  func hideTime()
  func togglePauseTimer()
  func cancelTimer()
  func state() -> TimeManagerState
  func isPaused() -> Bool
}

class ToolbeltView: UIView {
  var gameLifeViewModel: GameLifeViewModel
  var multiplayerButton: UIButton
  var poisonButton: UIButton
  var timerButton: UIButton
  var resetButton: UIButton
  var timeManager: TimeManager

  let buttonSize = 60.0
  
  init(gameLifeViewModel: GameLifeViewModel, timeManager: TimeManager) {
    self.gameLifeViewModel = gameLifeViewModel
    self.timeManager = timeManager
    multiplayerButton = UIButton()
    poisonButton = UIButton()
    timerButton = UIButton()
    resetButton = UIButton()

    super.init(frame: CGRectZero)
    
    backgroundColor = .black
    
    addSubview(multiplayerButton)
    addSubview(poisonButton)
    addSubview(timerButton)
    addSubview(resetButton)
    
    multiplayerButton.titleLabel?.font = UIFont(name: "ArialRoundedMTBold", size: 30)
    multiplayerButton.setTitle(multiplayerButtonTitle(), for: .normal)
    multiplayerButton.backgroundColor = .white
    multiplayerButton.setTitleColor(.black, for: .normal)
    multiplayerButton.layer.cornerRadius = buttonSize / 2.0
    multiplayerButton.addTarget(self, action: #selector(didTapTogglePlayerCount), for: .touchUpInside)
    
    poisonButton.titleLabel?.font = UIFont(name: "ArialRoundedMTBold", size: 40)
    poisonButton.setTitle("Φ", for: .normal)
    poisonButton.backgroundColor = .white
    poisonButton.setTitleColor(.black, for: .normal)
    poisonButton.layer.cornerRadius = buttonSize / 2.0
    poisonButton.addTarget(self, action: #selector(didTapTogglePoison), for: .touchUpInside)
    
    timerButton.setImage(.clockIcon, for: .normal)
    timerButton.imageEdgeInsets = UIEdgeInsets(top: 14, left: 14, bottom: 14, right: 14)
    timerButton.backgroundColor = .white
    timerButton.layer.cornerRadius = buttonSize / 2.0
    timerButton.addTarget(self, action: #selector(didTapTimerButton), for: .touchUpInside)
    
    resetButton.setImage(.resetIcon, for: .normal)
    resetButton.addTarget(self, action: #selector(notifyDidTapResetButton), for: .touchUpInside)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func multiplayerButtonTitle() -> String {
    switch gameLifeViewModel.playerCount {
    case .twoPlayer:
        return "4P"
    case .fourPlayer:
      return "2P"
    }
  }
  
  func updatePlayerCountButton() {
      multiplayerButton.setTitle(multiplayerButtonTitle(), for: .normal)
  }

  override func layoutSubviews() {
    let padding = 30.0
    multiplayerButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      multiplayerButton.centerYAnchor.constraint(equalTo: centerYAnchor),
      multiplayerButton.leftAnchor.constraint(equalTo: leftAnchor, constant: padding),
      multiplayerButton.heightAnchor.constraint(equalToConstant: buttonSize),
      multiplayerButton.widthAnchor.constraint(equalToConstant: buttonSize)
    ])
    
    resetButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      resetButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
      resetButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -padding),
      resetButton.heightAnchor.constraint(equalToConstant: buttonSize),
      resetButton.widthAnchor.constraint(equalToConstant: buttonSize)
    ])
    
    poisonButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      poisonButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
      poisonButton.leftAnchor.constraint(equalTo: multiplayerButton.rightAnchor, constant:padding),
      poisonButton.heightAnchor.constraint(equalToConstant: buttonSize),
      poisonButton.widthAnchor.constraint(equalToConstant: buttonSize)
    ])
    
    timerButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      timerButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
      timerButton.rightAnchor.constraint(equalTo: resetButton.leftAnchor, constant: -padding),
      timerButton.heightAnchor.constraint(equalToConstant: buttonSize),
      timerButton.widthAnchor.constraint(equalToConstant: buttonSize)
    ])
  }
  
  @objc func didTapTogglePlayerCount() {
    gameLifeViewModel.togglePlayerCount()
  }
  
  @objc func didTapTogglePoison() {
    gameLifeViewModel.togglePoison()
  }
  
  @objc func didTapTimerButton() {
    switch timeManager.state() {
    case .uninitialized:
      timeManager.initializeTime()
    case .shown:
      timeManager.hideTime()
    case .hidden:
      timeManager.displayTime()
    }
  }
  
  @objc func notifyDidTapResetButton() {
    NotificationCenter.default.post(name: Notification.Name(rawValue: GameNotifications.GameDidTapResetNotification), object: self)
  }
  
}
