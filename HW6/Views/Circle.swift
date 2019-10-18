//
//  Circle.swift
//  ECE564_HOMEWORK
//
//  Created by Trevor Stevenson on 9/26/19.
//  Copyright © 2019 ece564. All rights reserved.
//

import UIKit

/// A circle view
final class Circle: UIView {
    init() {
        super.init(frame: .zero)

        backgroundColor = .clear
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: CGRect) {
        let borderWidth: CGFloat = 5

        let cirlce = UIBezierPath(
            ovalIn: bounds.insetBy(dx: borderWidth / 2, dy: borderWidth / 2)
        )
        cirlce.lineWidth = borderWidth

        UIColor.black.setStroke()
        UIColor.white.setFill()

        cirlce.fill()
        cirlce.stroke()
    }
}
