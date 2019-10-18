//
//  View+Constraints.swift
//  ECE564_HOMEWORK
//
//  Created by Trevor Stevenson on 9/21/19.
//  Copyright © 2019 ece564. All rights reserved.
//

import UIKit

extension UIView {
    /// Adds the provided view as a subview and pins its edges to the
    /// parent with auto layout constraints
    func addEdgeMatchedSubview(_ view: UIView, inset: CGFloat = 0.0) {
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false

        view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: inset).isActive = true
        view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -inset).isActive = true
        view.topAnchor.constraint(equalTo: topAnchor, constant: inset).isActive = true
        view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -inset).isActive = true
    }

    /// Sets a width auto layout constraint
    func makeWidth(_ width: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: width).isActive = true
    }

    /// Sets a height auto layout constraint
    func makeHeight(_ height: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }

    /// Creates an auto layout constraint for equal width and height
    func makeEqualWidthHeight() {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalTo: heightAnchor).isActive = true
    }

    /// Pin to the left edge of superview with optional inset
    func pinLeft(inset: CGFloat = 0.0) {
        guard let superView = superview else {
            return
        }

        translatesAutoresizingMaskIntoConstraints = false
        leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: inset).isActive = true
    }

    /// Pin to the right edge of superview with optional inset
    func pinRight(inset: CGFloat = 0.0) {
        guard let superView = superview else {
            return
        }

        translatesAutoresizingMaskIntoConstraints = false
        trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: -inset).isActive = true
    }

    /// Pin to the top edge of superview with optional inset
    func pinTop(inset: CGFloat = 0.0) {
        guard let superView = superview else {
            return
        }

        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: superView.topAnchor, constant: inset).isActive = true
    }

    /// Pin to the bottom edge of superview with optional inset
    func pinBottom(inset: CGFloat = 0.0) {
        guard let superView = superview else {
            return
        }

        translatesAutoresizingMaskIntoConstraints = false
        bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: -inset).isActive = true
    }

    /// Make center the same as superview
    func makeCenter() {
        guard let superView = superview else {
            return
        }

        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: superView.centerXAnchor).isActive = true
        centerYAnchor.constraint(equalTo: superView.centerYAnchor).isActive = true
    }

    /// Make width the same as superview
    func makeEqualWidth() {
        guard let superView = superview else {
            return
        }

        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalTo: superView.widthAnchor).isActive = true
    }
}
