//
//  SearchResultsView.swift
//  ShopApp
//
//  Created by Codex on 3/25/26.
//

import UIKit

final class SearchResultsView: UIView {

    private let searchQuery: String

    let searchTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Search products"
        textField.borderStyle = .roundedRect
        textField.autocapitalizationType = .none
        textField.clearButtonMode = .whileEditing
        return textField
    }()

    let searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Search", for: .normal)
        button.configuration = .filled()
        return button
    }()

    var onResultTap: ((Int) -> Void)?

    private let queryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        return label
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Search Results"
        label.font = .preferredFont(forTextStyle: .title2)
        return label
    }()

    private lazy var resultButtons: [UIButton] = (0..<4).map(makeResultButton(for:))

    private let resultsGrid: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.distribution = .fillEqually
        return stackView
    }()

    private let emptyStateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .body)
        label.textAlignment = .center
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        label.isHidden = true
        return label
    }()

    init(searchQuery: String) {
        self.searchQuery = searchQuery
        super.init(frame: .zero)
        configureView()
        configureLayout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureView() {
        backgroundColor = .systemBackground

        addSubview(searchTextField)
        addSubview(searchButton)
        addSubview(queryLabel)
        addSubview(titleLabel)
        addSubview(resultsGrid)
        addSubview(emptyStateLabel)

        searchTextField.text = searchQuery
        queryLabel.text = searchQuery.isEmpty ? "Showing results for all products." : "Showing results for: \(searchQuery)"

        let firstRow = makeResultRow(buttons: Array(resultButtons.prefix(2)))
        let secondRow = makeResultRow(buttons: Array(resultButtons.suffix(2)))
        resultsGrid.addArrangedSubview(firstRow)
        resultsGrid.addArrangedSubview(secondRow)
    }

    private func configureLayout() {
        NSLayoutConstraint.activate([
            searchTextField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 24),
            searchTextField.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),

            searchButton.leadingAnchor.constraint(equalTo: searchTextField.trailingAnchor, constant: 12),
            searchButton.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            searchButton.centerYAnchor.constraint(equalTo: searchTextField.centerYAnchor),

            searchTextField.heightAnchor.constraint(equalToConstant: 44),
            searchButton.widthAnchor.constraint(equalToConstant: 100),
            searchButton.heightAnchor.constraint(equalToConstant: 44),

            queryLabel.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 16),
            queryLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            queryLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),

            titleLabel.topAnchor.constraint(equalTo: queryLabel.bottomAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),

            resultsGrid.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            resultsGrid.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            resultsGrid.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            resultsGrid.heightAnchor.constraint(equalToConstant: 320),

            emptyStateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            emptyStateLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            emptyStateLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor)
        ])
    }

    func display(products: [Product]) {
        emptyStateLabel.isHidden = products.isEmpty == false
        emptyStateLabel.text = products.isEmpty ? "No products matched your search." : nil

        for (index, button) in resultButtons.enumerated() {
            guard index < products.count else {
                button.isHidden = true
                button.isEnabled = false
                continue
            }

            let product = products[index]
            var configuration = UIButton.Configuration.filled()
            configuration.image = UIImage(systemName: product.imageSystemName)
            configuration.imagePlacement = .top
            configuration.imagePadding = 12
            configuration.title = product.name
            configuration.baseBackgroundColor = .systemGray6
            configuration.baseForegroundColor = .label
            configuration.cornerStyle = .large

            button.configuration = configuration
            button.tintColor = .label
            button.isHidden = false
            button.isEnabled = true
            button.accessibilityLabel = product.name
        }
    }

    private func makeResultRow(buttons: [UIButton]) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: buttons)
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.distribution = .fillEqually
        return stackView
    }

    private func makeResultButton(for index: Int) -> UIButton {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tag = index
        var configuration = UIButton.Configuration.filled()
        configuration.image = UIImage(systemName: "photo")
        configuration.baseBackgroundColor = .systemGray6
        configuration.baseForegroundColor = .systemGray2
        configuration.cornerStyle = .large
        button.configuration = configuration
        button.addTarget(self, action: #selector(handleResultTap(_:)), for: .touchUpInside)
        return button
    }

    @objc
    private func handleResultTap(_ sender: UIButton) {
        onResultTap?(sender.tag)
    }
}
