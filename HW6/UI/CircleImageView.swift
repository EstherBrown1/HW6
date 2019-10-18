//
//  CircleImageView.swift
//  ECE564_HOMEWORK
//
//  Created by Trevor Stevenson on 10/6/19.
//  Copyright © 2019 ece564. All rights reserved.
//

import UIKit

/// A circular image view
final class CircleImageView: UIView {
    /// Size of image view
    var size: CGFloat = 0.0 {
        didSet {
            imageView.makeWidth(size)
            imageView.layer.cornerRadius = size / 2
        }
    }

    /// Image
    var image: UIImage? {
        get {
            return imageView.image
        }

        set {
            imageView.image = newValue
        }
    }

    /// Content mode
    override var contentMode: UIView.ContentMode {
        get {
            return imageView.contentMode
        }

        set {
            imageView.contentMode = newValue
        }
    }

    /// Image view
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.makeEqualWidthHeight()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = bounds.height / 2

        return view
    }()

    init() {
        super.init(frame: .zero)

        addEdgeMatchedSubview(imageView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

