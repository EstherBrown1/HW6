//
//  NSLayoutAnchor+Constraints.swift
//  ECE564_HOMEWORK
//
//  Created by Trevor Stevenson on 9/22/19.
//  Copyright © 2019 ece564. All rights reserved.
//

import UIKit

extension NSLayoutAnchor {
    @objc func makeGreaterThanOrEqualTo(_ anchor: NSLayoutAnchor, constant: CGFloat = 0.0) {
        NSLayoutConstraint.activate([
            constraint(greaterThanOrEqualTo: anchor, constant: constant),
        ])
    }

    @objc func makeLessThanOrEqualTo(_ anchor: NSLayoutAnchor, constant: CGFloat = 0.0) {
        NSLayoutConstraint.activate([
            constraint(lessThanOrEqualTo: anchor, constant: -constant),
        ])
    }

    @objc func makeEqual(_ anchor: NSLayoutAnchor, constant: CGFloat = 0.0) {
        NSLayoutConstraint.activate([
            constraint(equalTo: anchor, constant: constant),
        ])
    }
}
