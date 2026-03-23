//
//  LifeTrackerView.swift
//  LifeHack
//
//  Created by Jimmy Lee on 11/26/23.
//

import Foundation
import UIKit

var toolbeltHeight = 100.0
var dividerWidth = 8.0

protocol TimeDisplayingView: UIView {
  func updateTime(_ seconds: Int)
  func displayTimer()
  func hideTimer()
}

class LifeTrackerView: UIView, TimeDisplayingView {
  private var _gameLifeViewModel: GameLifeViewModel
  var gameLifeViewModel: GameLifeViewModel {
    get {
      return _gameLifeViewModel
    }
    set {
      _gameLifeViewModel = newValue
      setUpWithModel(gameLifeViewModel: newValue)
    }
  }
  var p1LifeView: PlayerFullLifeView?
  var p2LifeView: PlayerFullLifeView? // without ?
  var p3LifeView: PlayerFullLifeView?
  var p4LifeView: PlayerFullLifeView?
  var toolbeltView: ToolbeltView
  
  var timeManager: TimeManager
  var timerView: UILabel
  var timerToolbeltView: TimerToolbeltView
  
  func updateTime(_ totalSeconds: Int) {
    let minutes = totalSeconds / 60
    let seconds = totalSeconds % 60
    var minutesText = String(minutes)
    if minutes < 10 {
      minutesText = "0" + minutesText
    }
    var secondsText = String(seconds)
    if seconds < 10 {
      secondsText = "0" + secondsText
    }
    
    let textFormat = String(format: "%@:%@", minutesText, secondsText)
    timerView.text = textFormat
  }
  
  func displayTimer() {
    timerView.isHidden = false
    timerToolbeltView.isHidden = false
  }
  
  func hideTimer() {
    timerView.isHidden = true
    timerToolbeltView.isHidden = true
  }
  
  init(gameLifeViewModel: GameLifeViewModel,
       timeManager: TimeManager,
       frame: CGRect) {
    _gameLifeViewModel = gameLifeViewModel
    self.toolbeltView = ToolbeltView(gameLifeViewModel: gameLifeViewModel, timeManager: timeManager)
    self.timeManager = timeManager
    timerView = UILabel()
    timerToolbeltView = TimerToolbeltView(frame: frame, timeManager: timeManager)
    super.init(frame: frame)
    self.backgroundColor = .black
    setUpWithModel(gameLifeViewModel: gameLifeViewModel)
  }
  
  func setUpTimerView() {
    timerView.backgroundColor = .black
    timerView.textColor = .white
    timerView.textAlignment = .center
    timerView.font = UIFont(name: "ArialRoundedMTBold", size: 34)
    timerView.clipsToBounds = true
    timerView.layer.cornerRadius = 10.0
    timerView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    switch timeManager.state() {
    case .uninitialized:
      timerView.isHidden = true
      timerToolbeltView.isHidden = true
    case .shown:
      timerView.isHidden = false
      timerToolbeltView.isHidden = false
    case .hidden:
      timerView.isHidden = true
      timerToolbeltView.isHidden = true
    }
  }

  private func setUpWithModel(gameLifeViewModel: GameLifeViewModel) {
    _gameLifeViewModel = gameLifeViewModel
    for subview in self.subviews {
      subview.removeFromSuperview()
    }
    switch gameLifeViewModel.playerCount {
    case .twoPlayer:
      p1LifeView = PlayerFullLifeView(playerLifeViewModel: gameLifeViewModel.player1,
                                      transform: CGAffineTransformIdentity,
                                      isFlipped: false,
                                      frame: cellFrameFor2P())
      p2LifeView = PlayerFullLifeView(playerLifeViewModel: gameLifeViewModel.player2,
                                      transform: CGAffineTransform(rotationAngle: CGFloat.pi),
                                      isFlipped: true,
                                      frame: cellFrameFor2P())
      p1LifeView!.setLifeColor(lightBlueColor)
      p2LifeView!.setLifeColor(tealColor)
      addSubview(self.p1LifeView!)
      addSubview(self.p2LifeView!)
    case .fourPlayer:
      p1LifeView = PlayerFullLifeView(playerLifeViewModel: gameLifeViewModel.player1Of4,
                                      transform: CGAffineTransform(rotationAngle: 0.5 * .pi),
                                      isFlipped: false,
                                      frame: cellFrameFor4P())
      p2LifeView = PlayerFullLifeView(playerLifeViewModel: gameLifeViewModel.player2Of4,
                                      transform: CGAffineTransform(rotationAngle: 0.5 * .pi),
                                      isFlipped: false,
                                      frame: cellFrameFor4P())
      p3LifeView = PlayerFullLifeView(playerLifeViewModel: gameLifeViewModel.player3Of4,
                                      transform: CGAffineTransform(rotationAngle: 1.5 * .pi),
                                      isFlipped: true,
                                      frame: cellFrameFor4P())
      p4LifeView = PlayerFullLifeView(playerLifeViewModel: gameLifeViewModel.player4Of4,
                                      transform: CGAffineTransform(rotationAngle: 1.5 * .pi),
                                      isFlipped: true,
                                      frame: cellFrameFor4P())
      addSubview(p1LifeView!)
      addSubview(p2LifeView!)
      addSubview(p3LifeView!)
      addSubview(p4LifeView!)
    }
    toolbeltView.updatePlayerCountButton()
    addSubview(toolbeltView)
    setUpTimerView()
    addSubview(timerView)
    addSubview(timerToolbeltView)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    switch gameLifeViewModel.playerCount {
    case .twoPlayer:
      p3LifeView?.isHidden = true
      p4LifeView?.isHidden = true
      layoutSubviewsFor2P()
    case .fourPlayer:
      p3LifeView?.isHidden = false
      p4LifeView?.isHidden = false
      layoutSubviewsFor4P()
    }
    
    toolbeltView.frame = CGRect(x: 0, y: 0.5 * (self.frame.height - toolbeltHeight), width: self.frame.width, height: toolbeltHeight)
    let timerWidth = 130.0
    let timerHeight = 50.0
    timerView.frame = CGRect(x: (frame.width - timerWidth) / 2, y: toolbeltView.frame.origin.y - timerHeight,
                             width: timerWidth, height: timerHeight)
    timerToolbeltView.frame = timerView.frame
    timerToolbeltView.frame.origin.y = toolbeltView.frame.origin.y + toolbeltHeight
  }
  
  func layoutSubviewsFor2P() {
    let frame = cellFrameFor2P()
    let quadrantY = (self.frame.height + toolbeltHeight) / 2.0

    p1LifeView?.frame = CGRectMake(0, quadrantY, frame.width, frame.height)
    p2LifeView?.frame = CGRectMake(0, 0, frame.width, frame.height)
  }
  
  func layoutSubviewsFor4P() {
    let frame = cellFrameFor4P()
    let quadrantX = (self.frame.width + dividerWidth) / 2.0
    let quadrantY = (self.frame.height + toolbeltHeight) / 2.0
    
    p1LifeView?.frame = CGRectMake(0, 0, frame.width, frame.height)
    p2LifeView?.frame = CGRectMake(0, quadrantY, frame.width, frame.height)
    p3LifeView?.frame = CGRectMake(quadrantX, 0, frame.width, frame.height)
    p4LifeView?.frame = CGRectMake(quadrantX, quadrantY, frame.width, frame.height)
  }
  
  func cellFrameFor2P() -> CGRect {
    let cellHeight = (self.frame.height - toolbeltHeight) / 2.0
    return CGRectMake(0, 0, self.frame.width, cellHeight)
  }
  
  func cellFrameFor4P() -> CGRect {
    let cellHeight = (self.frame.height - toolbeltHeight) / 2.0
    let cellWidth = (self.frame.width - dividerWidth) / 2.0
    return CGRectMake(0, 0, cellWidth, cellHeight)
  }
}
