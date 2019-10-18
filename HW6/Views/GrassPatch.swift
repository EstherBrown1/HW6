//
//  GrassPatch.swift
//  ECE564_HOMEWORK
//
//  Created by Trevor Stevenson on 9/27/19.
//  Copyright © 2019 ece564. All rights reserved.
//

import UIKit

/// A view for a patch of grass
final class GrassPatch: UIView {
    /// Height of patch - width set to 1/2 * height
    private let height: CGFloat

    init(height: CGFloat) {
        self.height = height

        super.init(frame: .zero)

        backgroundColor = .clear

        makeHeight(height)
        makeWidth(height / 2)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: CGRect) {
        let width = height / 2
        // Triangle 1
        let path1 = UIBezierPath()
        path1.move(to: CGPoint(x: 0, y: height))
        path1.addLine(to: CGPoint(x: 0, y: 0))
        path1.addLine(to: CGPoint(x: width / 2, y: height))
        path1.close()

        // Triangle 2
        let path2 = UIBezierPath()
        path2.move(to: CGPoint(x: width / 4, y: height))
        path2.addLine(to: CGPoint(x: width / 2, y: 0))
        path2.addLine(to: CGPoint(x: 3 * width / 4, y: height))
        path2.close()

        // Triangle 3
        let path3 = UIBezierPath()
        path3.move(to: CGPoint(x: width / 2, y: height))
        path3.addLine(to: CGPoint(x: width, y: 0))
        path3.addLine(to: CGPoint(x: width, y: height))
        path3.close()

        UIColor.mint.setFill()
        UIColor.mint.darker(factor: 0.5).setStroke()

        path1.fill()
        path1.stroke()

        path3.fill()
        path3.stroke()

        path2.fill()
        path2.stroke()
    }
}
