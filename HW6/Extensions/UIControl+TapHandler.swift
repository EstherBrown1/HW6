//
//  UIControl+TapHandler.swift
//  ECE564_HOMEWORK
//
//  Created by Trevor Stevenson on 9/22/19.
//  Copyright © 2019 ece564. All rights reserved.
//

import UIKit

private var key: UInt8 = 0

extension UIControl {
    public typealias TapHandler = (() -> Void)

    /// A tap handler for any control
    @objc open var tapHandler: TapHandler? {
        get {
            return objc_getAssociatedObject(self, &key) as? TapHandler
        }
        set {
            if tapHandler == nil, newValue != nil {
                addTarget(self, action: #selector(handleTap), for: .touchUpInside)
            } else if tapHandler != nil, newValue == nil {
                removeTarget(self, action: #selector(handleTap), for: .touchUpInside)
            }

            objc_setAssociatedObject(self, &key, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }

    @objc private func handleTap() {
        tapHandler?()
    }
}
