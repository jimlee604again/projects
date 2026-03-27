//
//  ViewController.swift
//  ShopApp
//
//  Created by Jimmy Lee on 3/25/26.
//

import UIKit

class HomePageViewController: UIViewController {

  var navigationCoordinator: NavigationCoordinator?
  private let homePageView = HomePageView()

  override func loadView() {
    view = homePageView
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Home"
    homePageView.delegate = self
  }

}

extension HomePageViewController: HomePageViewDelegate {
  private func handleSearchButtonTap(query: String) {
    navigationCoordinator?.showSearchResults(for: query)
  }

  func homePageView(_ homePageView: HomePageView, didTapSearchWith query: String) {
    handleSearchButtonTap(query: query)
  }
}
