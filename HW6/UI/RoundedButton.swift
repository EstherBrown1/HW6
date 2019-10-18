//
//  RoundedButton.swift
//  ECE564_HOMEWORK
//
//  Created by Trevor Stevenson on 9/13/19.
//  Copyright © 2019 ece564. All rights reserved.
//

import UIKit

/// A rounded rectangle button
final class RoundedButton: UIButton {
    init(text: String, color: UIColor) {
        super.init(frame: .zero)

        backgroundColor = color
        setTitle(text, for: .normal)
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)

        drawCorners()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func drawCorners() {
        layer.cornerRadius = .standard / 2
    }
}
