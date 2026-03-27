//
//  HomePageView.swift
//  ShopApp
//
//  Created by Codex on 3/25/26.
//

import UIKit

protocol HomePageViewDelegate: AnyObject {
    func homePageView(_ homePageView: HomePageView, didTapSearchWith query: String)
}

final class HomePageView: UIView {

    weak var delegate: HomePageViewDelegate?

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

    private let productImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "photo.artframe"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemGray2
        imageView.backgroundColor = .systemGray6
        imageView.layer.cornerRadius = 16
        imageView.clipsToBounds = true
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Featured Finds"
        label.font = .preferredFont(forTextStyle: .title2)
        label.textAlignment = .center
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Explore trending items, seasonal picks, and everyday essentials from our sample catalog."
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
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
        addSubview(productImageView)
        addSubview(titleLabel)
        addSubview(descriptionLabel)

        searchButton.addTarget(self, action: #selector(handleSearchButtonTap), for: .touchUpInside)
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

            productImageView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 24),
            productImageView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            productImageView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            productImageView.heightAnchor.constraint(equalToConstant: 240),

            titleLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),

            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            descriptionLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor)
        ])
    }

    @objc private func handleSearchButtonTap() {
        let query = searchTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        delegate?.homePageView(self, didTapSearchWith: query)
    }
}
