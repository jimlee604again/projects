//
//  ItemsViewController.swift
//  NightfallSwift
//
//  Created by Jimmy Lee on 3/11/26.
//

import UIKit

class ItemsViewController: UIViewController, ItemsViewDelegate, ItemsViewModelDelegate {

  private let itemsViewModel: ItemsViewModel

  init(itemsViewModel: ItemsViewModel) {
    self.itemsViewModel = itemsViewModel
    super.init(nibName: nil, bundle: nil)
    let itemsView = ItemsView()
    itemsView.configure(with: itemsViewModel.viewState)
    self.view = itemsView
    itemsView.itemsViewDelegate = self
    itemsViewModel.delegate = self
  }

  func didTapExit() {
    dismiss(animated: false)
  }

  func didTapUsePotion() {
    switch itemsViewModel.attemptUsePotion() {
    case .used:
      presentSimpleAlert(title: itemsViewModel.usedPotionAlertTitle, message: itemsViewModel.usedPotionAlertMessage)
      break
    case .noneLeft:
      presentSimpleAlert(title: itemsViewModel.noPotionsLeftAlertTitle, message: nil)
      break
    }
  }

  func itemsViewModel(_ viewModel: ItemsViewModel, didUpdate viewState: ItemsViewState) {
    (view as? ItemsView)?.configure(with: viewState)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}
