//
//  TitleView.swift
//  NightfallSwift
//
//  Created by Jimmy Lee on 1/21/26.
//

import Foundation
import UIKit

class TitleView : UIView {
  private let titleText : UILabel
  
  init() {
    self.titleText = UILabel()
    self.titleText.text = "Nightfall"
    self.titleText.textColor = .white
    
    super.init(frame: CGRectZero)
    
//    self.backgroundColor = .black
    self.backgroundColor = .red
    self.addSubview(self.titleText)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
