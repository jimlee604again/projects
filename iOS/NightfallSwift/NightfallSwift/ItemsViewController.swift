//
//  ItemsViewController.swift
//  NightfallSwift
//
//  Created by Jimmy Lee on 3/11/26.
//

import UIKit

class ItemsViewController: UIViewController, ItemsViewDelegate {
  
  private let itemsViewModel: ItemsViewModel
  
  init(itemsViewModel: ItemsViewModel) {
    self.itemsViewModel = itemsViewModel
    super.init(nibName: nil, bundle: nil)
    let itemsView = ItemsView(itemsViewModel: itemsViewModel)
    self.view = itemsView
    itemsView.itemsViewDelegate = self
  }
  
  func didTapExit() {
    self.dismiss(animated: false)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
