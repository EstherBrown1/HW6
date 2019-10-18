//
//  SoccerBall.swift
//  ECE564_HOMEWORK
//
//  Created by Trevor Stevenson on 9/26/19.
//  Copyright © 2019 ece564. All rights reserved.
//

import UIKit

/// A black and white soccer ball
final class SoccerBall: UIView {
    /// Size of soccer ball
    private let size: CGFloat

    init(size: CGFloat) {
        self.size = size

        super.init(frame: .zero)

        backgroundColor = .clear

        makeWidth(size)
        makeEqualWidthHeight()

        setupSubviews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupSubviews() {
        addEdgeMatchedSubview(Circle())

        // Number of pentagons in each row/column
        let numPentagons = 3

        // Scale factor for size of pentagon
        let scale: CGFloat = 5

        // Tesselate nxn grid of pentagons
        for i in 0..<numPentagons {
            for j in 0..<numPentagons {
                let pentagon = Pentagon(size: size / scale)

                addSubview(pentagon)
                pentagon.leadingAnchor.constraint(
                    equalTo: leadingAnchor,
                    constant: CGFloat(i) * size / CGFloat(numPentagons) + size / (scale * 3)
                ).isActive = true

                pentagon.topAnchor.constraint(
                    equalTo: topAnchor,
                    constant: CGFloat(j) * size / CGFloat(numPentagons) + size / (scale * 3)
                ).isActive = true
            }
        }

        // Clip the subviews to the border of the ball
        let ovalPath = UIBezierPath(
            ovalIn: CGRect(x: 0, y: 0, width: size, height: size)
        )
        let maskLayer = CAShapeLayer()
        maskLayer.path = ovalPath.cgPath

        layer.mask = maskLayer
    }
}
