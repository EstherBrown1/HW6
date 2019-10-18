//
//  Pentagon.swift
//  ECE564_HOMEWORK
//
//  Created by Trevor Stevenson on 9/26/19.
//  Copyright © 2019 ece564. All rights reserved.
//

import UIKit

/// A pentagon shape
final class Pentagon: UIView {
    /// Size of shape
    private let size: CGFloat

    /// Color of shape
    private let color: UIColor

    init(size: CGFloat, color: UIColor = .black) {
        self.size = size
        self.color = color

        super.init(frame: .zero)

        makeWidth(size)
        makeEqualWidthHeight()

        backgroundColor = .clear
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: CGRect) {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: size / 2, y: 0))
        path.addLine(to: CGPoint(x: size, y: size / 3))
        path.addLine(to: CGPoint(x: 3 * size / 4, y: size))
        path.addLine(to: CGPoint(x: size / 4, y: size))
        path.addLine(to: CGPoint(x: 0, y: size / 3))
        path.close()

        color.setFill()
        path.fill()
    }
}
