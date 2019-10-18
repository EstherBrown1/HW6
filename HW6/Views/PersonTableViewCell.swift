//
//  PersonTableViewCell.swift
//  ECE564_HOMEWORK
//
//  Created by Trevor Stevenson on 9/21/19.
//  Copyright © 2019 ece564. All rights reserved.
//

import UIKit

/// A cell to display information about a person
final class PersonTableViewCell: UITableViewCell {
    /// Avatar image view
    private lazy var avatarImageView: CircleImageView = {
        let view = CircleImageView()
        view.size = bounds.width / 3
        view.contentMode = .scaleAspectFit

        return view
    }()

    /// Name label
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.adjustsFontSizeToFitWidth = true

        return label
    }()

    /// Description label
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0

        return label
    }()

    /// Vertical information stack view
    private lazy var infoStackView: UIStackView = {
        let stack = UIStackView(
            arrangedSubviews: [
                nameLabel,
                descriptionLabel,
            ]
        )
        stack.axis = .vertical
        stack.alignment = .leading
        stack.spacing = 5

        return stack
    }()

    /// Horizontal content stack view
    private lazy var contentStackView: UIStackView = {
        let stack = UIStackView(
            arrangedSubviews: [
                avatarImageView,
                infoStackView,
            ]
        )
        stack.spacing = 16
        stack.alignment = .center

        return stack
    }()

    init(person: DukePerson) {
        super.init(style: .default, reuseIdentifier: nil)

        nameLabel.text = "\(person.firstName) \(person.lastName)"
        descriptionLabel.text = person.description
        avatarImageView.image = person.picture

        addEdgeMatchedSubview(contentStackView, inset: 15)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
