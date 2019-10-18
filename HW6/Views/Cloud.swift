//
//  Cloud.swift
//  ECE564_HOMEWORK
//
//  Created by Trevor Stevenson on 9/27/19.
//  Copyright © 2019 ece564. All rights reserved.
//

import UIKit

/// A cloud view
final class Cloud: UIView {
    /// Radius of the cloud curves
    private let radius: CGFloat

    /// Width of cloud
    private var width: CGFloat {
        return 4 * radius
    }

    /// Height of cloud
    private var height: CGFloat {
        return 3 * radius
    }

    init(radius: CGFloat) {
        self.radius = radius

        super.init(frame: .zero)

        backgroundColor = .clear

        makeWidth(width)
        makeHeight(height)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: CGRect) {
        let path1 = UIBezierPath(
            ovalIn: CGRect(
                x: radius,
                y: radius,
                width: 2 * radius,
                height: 2 * radius
            )
        )

        let path2 = UIBezierPath(
            ovalIn: CGRect(
                x: 0,
                y: radius,
                width: 2 * radius,
                height: 2 * radius
            )
        )

        let path3 = UIBezierPath(
            ovalIn: CGRect(
                x: 2 * radius,
                y: radius,
                width: 2 * radius,
                height: 2 * radius
            )
        )

        let path4 = UIBezierPath(
            ovalIn: CGRect(
                x: radius,
                y: 0,
                width: 2 * radius,
                height: 2 * radius
            )
        )

        UIColor.white.setFill()
        path1.fill()
        path2.fill()
        path3.fill()
        path4.fill()
    }
}
