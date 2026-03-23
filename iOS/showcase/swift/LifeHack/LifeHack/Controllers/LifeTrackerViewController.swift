//
//  LifeTrackerViewController.swift
//  LifeHack
//
//  Created by Jimmy Lee on 11/26/23.
//

import Foundation
import UIKit
import AudioToolbox

class LifeTrackerViewController: UIViewController, TimeManager {
  var gameLifeViewModel: GameLifeViewModel
  var lifeTrackerView: LifeTrackerView?
  // Time Manager
  var timerState: TimeManagerState
  var timerPaused: Bool
  var timer: Timer?
  var timeRemaining: Int // update to milliseconds for pause precision
  static let timerStartTime: Int = 50 * 60
  
  // Time Manager
  func initializeTime() {
    timeRemaining = LifeTrackerViewController.timerStartTime
    runTimer()
  }
  
  func runTimer() {
    if let lifeTrackerView = lifeTrackerView {
      lifeTrackerView.updateTime(timeRemaining)
      displayTime()
      timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { timer in
        if self.timeRemaining == 0 {
          timer.invalidate()
          self.presentTimerFinishedDialog()
          AudioServicesPlaySystemSound(SystemSoundID(1000))
          return
        }
        self.timeRemaining -= 1
        lifeTrackerView.updateTime(self.timeRemaining)
      })
    }
  }

  func isPaused() -> Bool {
    return timerPaused
  }
  
  func displayTime() {
    lifeTrackerView?.displayTimer()
    timerState = .shown
  }
  
  func hideTime() {
    lifeTrackerView?.hideTimer()
    timerState = .hidden
  }
  
  func togglePauseTimer() {
    if timerPaused {
      runTimer()
    } else {
      timer?.invalidate()
    }
    timerPaused = !timerPaused
  }
  
  func cancelTimer() {
    timer?.invalidate()
    timeRemaining = LifeTrackerViewController.timerStartTime
    timerPaused = true
    lifeTrackerView?.updateTime(timeRemaining)
  }
  
  func state()->TimeManagerState {
    return timerState
  }
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    let startGameState = GameLifeData(playerCount: .twoPlayer,
                                      displayPoison: false,
                                      p1LifeData: PlayerLifeData(playerLife: startingLife2P, playerPoison: startingPoison),
                                      p2LifeData: PlayerLifeData(playerLife: startingLife2P, playerPoison: startingPoison),
                                      p1Of4LifeData: PlayerLifeData(playerLife: startingLife4P, playerPoison: startingPoison),
                                      p2Of4LifeData: PlayerLifeData(playerLife: startingLife4P, playerPoison: startingPoison),
                                      p3Of4LifeData: PlayerLifeData(playerLife: startingLife4P, playerPoison: startingPoison),
                                      p4Of4LifeData: PlayerLifeData(playerLife: startingLife4P, playerPoison: startingPoison))
    timerState = .uninitialized
    timerPaused = false
    timeRemaining = LifeTrackerViewController.timerStartTime
    self.gameLifeViewModel = GameLifeViewModel(withGame: startGameState)
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    self.lifeTrackerView = LifeTrackerView(gameLifeViewModel:self.gameLifeViewModel, timeManager: self, frame: self.view.frame)
    self.view = self.lifeTrackerView
    
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(gameStateDidChangeNotification(_:)),
                                           name: NSNotification.Name(rawValue: GameNotifications.GameStateDidChangeNotification),
                                           object: nil)
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(didTapResetNotification(_:)),
                                           name: NSNotification.Name(rawValue: GameNotifications.GameDidTapResetNotification),
                                           object: nil)
  }
  
  deinit {
    NotificationCenter.default.removeObserver(self)
  }
  
  required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  @objc private func gameStateDidChangeNotification(_ notification: NSNotification) {
    self.lifeTrackerView?.gameLifeViewModel = self.gameLifeViewModel
    self.view = self.lifeTrackerView
  }

  @objc private func didTapResetNotification(_ notification: NSNotification) {
    let alert = UIAlertController(title: "Reset Game", message: "Are you sure you wish to reset the life totals?", preferredStyle: UIAlertController.Style.alert)
    alert.addAction(UIAlertAction(title: "Reset", style: UIAlertAction.Style.destructive, handler: resetHandler))
    alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
    self.present(alert, animated: true, completion: nil)
  }
  
  func resetHandler(alert: UIAlertAction!) {
    self.gameLifeViewModel.resetLife()
  }
  
  func presentTimerFinishedDialog() {
    let alert = UIAlertController(title: "Time's up!", message: nil, preferredStyle: UIAlertController.Style.alert)
    alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default, handler: resetHandler))
    self.present(alert, animated: true, completion: nil)
  }
}
