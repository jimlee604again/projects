//
//  TitleViewModel.swift
//  NightfallSwift
//
//  Created by Jimmy Lee on 3/16/26.
//

import Foundation

struct TitleViewState {
  let titleText = "Nightfall"
  let startText = "Start"
}

struct TitleViewModel {
  let viewState : TitleViewState
  let playerStartingHealth: Int32 = 10
  let playerStartingGold: Int32 = 0

  init() {
    self.viewState = TitleViewState()
  }
}
