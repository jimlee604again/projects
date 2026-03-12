//
//  PlayerLifeView.swift
//  LifeHack
//
//  Created by Jimmy Lee on 12/2/23.
//

import Foundation
import UIKit

class PlayerFullLifeView: UIView {
  var playerLifeViewModel: PlayerLifeViewModel
  var lifeCounterView: PlayerCounterView
  var lifeIncrementButton: UIButton
  var lifeDecrementButton: UIButton
  var poisonCounterView: PlayerCounterView
  var poisonIncrementButton: UIButton
  var poisonDecrementButton: UIButton
  var viewTransform: CGAffineTransform
  var isFlipped: Bool

  init(playerLifeViewModel: PlayerLifeViewModel, transform: CGAffineTransform, isFlipped: Bool, frame: CGRect) {
    self.playerLifeViewModel = playerLifeViewModel
    
    let lifeBackgroundColor = UIColor(red: 66/255.0, green: 245/255.0, blue: 170/255.0, alpha: 1.0)
    lifeCounterView = PlayerCounterView(backgroundColor: lifeBackgroundColor, poisonEnabled: playerLifeViewModel.shouldDisplayPoison, frame: frame)
    lifeIncrementButton = UIButton()
    lifeDecrementButton = UIButton()
    poisonIncrementButton = UIButton()
    poisonDecrementButton = UIButton()
    
//    let poisonBackgroundColor = UIColor(red: 250/255.0, green: 155/255.0, blue: 240/255.0, alpha: 1.0)
    self.poisonCounterView = PlayerCounterView(backgroundColor: purpleColor, poisonEnabled: true, frame: frame)
    self.viewTransform = transform
    self.isFlipped = isFlipped
    
    super.init(frame: frame)
    
    self.addSubview(lifeCounterView)
    self.addSubview(poisonCounterView)
    self.addSubview(lifeIncrementButton)
    self.addSubview(lifeDecrementButton)
    self.addSubview(poisonIncrementButton)
    self.addSubview(poisonDecrementButton)
    
    self.lifeCounterView.setAttributedText(attributedText: playerLifeAttributedText())
    self.lifeIncrementButton.addTarget(self,
                                       action: #selector(tapIncrementLife),
                                       for: .touchDown)
    self.lifeDecrementButton.addTarget(self,
                                       action: #selector(tapDecrementLife),
                                       for: .touchDown)
    
    self.poisonCounterView.setAttributedText(attributedText: playerPoisonAttributedText())
    self.poisonIncrementButton.addTarget(self,
                                       action: #selector(tapIncrementPoison),
                                       for: .touchDown)
    self.poisonDecrementButton.addTarget(self,
                                       action: #selector(tapDecrementPoison),
                                       for: .touchDown)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func layoutSubviews() {
    let poisonEnabled = playerLifeViewModel.shouldDisplayPoison
    let multiplier = poisonEnabled ? 0.5 : 1.0
    self.poisonCounterView.isHidden = !poisonEnabled
    self.poisonIncrementButton.isHidden = !poisonEnabled
    self.poisonDecrementButton.isHidden = !poisonEnabled

    self.lifeCounterView.transform = viewTransform
    self.poisonCounterView.transform = viewTransform
   
    switch playerLifeViewModel.playerCount {
    case .twoPlayer:
      self.lifeCounterView.frame = CGRect(x: 0,
                                          y: 0,
                                          width: multiplier * self.frame.width,
                                          height: self.frame.height)
      self.poisonCounterView.frame = CGRect(x: 0.5 * self.frame.width,
                                            y: 0,
                                            width: multiplier * self.frame.width,
                                            height: self.frame.height)
      self.lifeIncrementButton.frame = CGRect(x: 0,
                                              y: 0,
                                              width: multiplier * self.frame.width,
                                              height: 0.5 * self.lifeCounterView.frame.height)
      self.lifeDecrementButton.frame = CGRect(x: 0,
                                              y: 0.5 * self.lifeCounterView.frame.height,
                                              width: multiplier * self.frame.width,
                                              height: 0.5 * self.lifeCounterView.frame.height)
      self.poisonIncrementButton.frame = CGRect(x: 0.5 * self.frame.width,
                                              y: 0,
                                              width: self.poisonCounterView.frame.width,
                                              height: 0.5 * self.poisonCounterView.frame.height)
      self.poisonDecrementButton.frame = CGRect(x: 0.5 * self.frame.width,
                                              y: 0.5 * self.poisonCounterView.frame.height,
                                              width: self.poisonCounterView.frame.width,
                                              height: 0.5 * self.poisonCounterView.frame.height)
    case .fourPlayer:
      self.lifeCounterView.frame = CGRect(x: 0,
                                          y: 0,
                                          width: self.frame.width,
                                          height: multiplier * self.frame.height)
      self.poisonCounterView.frame = CGRect(x: 0,
                                            y: 0.5 * self.frame.height,
                                            width: self.frame.width,
                                            height: multiplier * self.frame.height)
      self.lifeIncrementButton.frame = CGRect(x: 0.5 * self.lifeCounterView.frame.width,
                                              y: 0,
                                              width: 0.5 * self.frame.width,
                                              height: multiplier * self.frame.height)
      self.lifeDecrementButton.frame = CGRect(x: 0,
                                              y: 0,
                                              width: 0.5 * self.frame.width,
                                              height: multiplier * self.frame.height)
      self.poisonIncrementButton.frame = CGRect(x: 0.5 * self.frame.width,
                                                y: 0.5 * self.frame.height,
                                              width: self.frame.width,
                                              height: 0.5 * self.frame.height)
      self.poisonDecrementButton.frame = CGRect(x: 0,
                                                y: self.lifeCounterView.frame.height,
                                                width: 0.5 * self.poisonCounterView.frame.width,
                                                height: self.poisonCounterView.frame.height)
    }
    if (isFlipped) {
      if (poisonEnabled) {
        let newLifeFrame = self.poisonCounterView.frame
        self.poisonCounterView.frame = self.lifeCounterView.frame
        self.lifeCounterView.frame = newLifeFrame
        let newLifeIncrementFrame = poisonDecrementButton.frame
        poisonDecrementButton.frame = lifeIncrementButton.frame
        lifeIncrementButton.frame = newLifeIncrementFrame
        let newLifeDecrementFrame = poisonIncrementButton.frame
        poisonIncrementButton.frame = lifeDecrementButton.frame
        lifeDecrementButton.frame = newLifeDecrementFrame
      } else {
        let newLifeIncrementFrame = self.lifeDecrementButton.frame
        self.lifeDecrementButton.frame = self.lifeIncrementButton.frame
        self.lifeIncrementButton.frame = newLifeIncrementFrame
      }
    }
  }
  
  func attributedTextFont() -> [NSAttributedString.Key : Any] {
    var textSize = 180.0
    if (playerLifeViewModel.shouldDisplayPoison) {
      textSize *= 0.6
    }
    switch playerLifeViewModel.playerCount {
    case .twoPlayer:
      textSize *= 1
    case .fourPlayer:
      textSize *= 0.9
    }
    return [ NSAttributedString.Key.font: UIFont(name: "ChalkboardSE-Bold", size: textSize)! ]
  }
  
  func setLifeColor(_ color: UIColor) {
    lifeCounterView.setLifeColor(color)
  }
  
  func playerLifeAttributedText() -> NSAttributedString {
    return NSAttributedString(string: "\(playerLifeViewModel.life)", attributes: attributedTextFont())
  }
  
  func playerPoisonAttributedText() -> NSAttributedString {
    return NSAttributedString(string: "\(playerLifeViewModel.poison)", attributes: attributedTextFont())
  }
  
  @objc func tapIncrementLife() {
    self.playerLifeViewModel.incrementLife()
  }

  @objc func tapDecrementLife() {
    self.playerLifeViewModel.decrementLife()
  }
  
  @objc func tapIncrementPoison() {
    self.playerLifeViewModel.incrementPoison()
  }

  @objc func tapDecrementPoison() {
    self.playerLifeViewModel.decrementPoison()
  }
}
