//
//  PlayerStatusViews.swift
//  NightfallSwift
//
//  Created by Codex on 3/18/26.
//

import UIKit

final class PlayerStatusView: UIView {
  private let hpLabel = LabelTemplate()
  private let goldLabel = LabelTemplate()
  private let stackView = StackTemplate()

  override init(frame: CGRect) {
    super.init(frame: frame)

    translatesAutoresizingMaskIntoConstraints = false

    stackView.addArrangedSubview(hpLabel)
    stackView.addArrangedSubview(goldLabel)

    addSubview(stackView)

    NSLayoutConstraint.activate([
      stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
      stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
      stackView.topAnchor.constraint(equalTo: topAnchor),
      stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func configure(hpText: String, goldText: String) {
    hpLabel.text = hpText
    goldLabel.text = goldText
  }
}

final class PlayerInventoryView: UIView {
  private let potionsLabel = LabelTemplate()
  private let crownsLabel = LabelTemplate()
  private let stackView = StackTemplate()

  override init(frame: CGRect) {
    super.init(frame: frame)

    translatesAutoresizingMaskIntoConstraints = false

    stackView.alignment = .center
    stackView.addArrangedSubview(potionsLabel)
    stackView.addArrangedSubview(crownsLabel)

    addSubview(stackView)

    NSLayoutConstraint.activate([
      stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
      stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
      stackView.topAnchor.constraint(equalTo: topAnchor),
      stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func configure(potionText: String, crownText: String) {
    potionsLabel.text = potionText
    crownsLabel.text = crownText
  }
}
