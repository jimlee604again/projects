//
//  InnView.swift
//  NightfallSwift
//
//  Created by Jimmy Lee on 2/11/26.
//

import UIKit

class InnView : UIView {
  private let player: Player
  
  init(player: Player) {
    self.player = player
    
    super.init(frame: CGRectZero)
    
    self.backgroundColor = .yellow
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
