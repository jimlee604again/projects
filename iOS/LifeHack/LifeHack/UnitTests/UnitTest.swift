//
//  UnitTest.swift
//  LifeHack
//
//  Created by Jimmy Lee on 9/15/25.
//

import Testing

@Test func testDecrementPlayerOneLife() async throws {
    // Write your test here and use APIs like `#expect(...)` to check expected conditions.
      func testDecreasePlayerOneLife() {
        let lifeTrackerVC = LifeTrackerViewController()
        let lifeTrackerView = lifeTrackerVC.lifeTrackerView
        let p1LifeView = lifeTrackerView?.p1LifeView
        p1LifeView?.tapDecrementLife()
        expect(lifeTrackerVC.gameLifeViewModel.player1.life == 19)
      }
}
