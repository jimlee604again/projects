//
//  SearchResultsViewController.swift
//  ShopApp
//
//  Created by Codex on 3/25/26.
//

import UIKit

final class SearchResultsViewController: UIViewController {

    private let viewModel: SearchResultsViewModel
    private lazy var searchResultsView = SearchResultsView(searchQuery: viewModel.query)

    init(viewModel: SearchResultsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = searchResultsView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Results"
        searchResultsView.onResultTap = { [weak self] index in
            self?.showItemDetail(for: index)
        }
        loadResults()
    }

    private func showItemDetail(for index: Int) {
    }

    private func loadResults() {
        Task { [weak self] in
            guard let self else { return }

            do {
                let products = try await viewModel.loadResults()
                await MainActor.run {
                    self.searchResultsView.display(products: products)
                }
            } catch {
                await MainActor.run {
                    self.searchResultsView.display(products: [])
                }
            }
        }
    }
}
