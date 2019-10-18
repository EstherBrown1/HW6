//
//  ScrollableStackView.swift
//  ECE564_HOMEWORK
//
//  Created by Trevor Stevenson on 9/21/19.
//  Copyright © 2019 ece564. All rights reserved.
//

import UIKit

/// A stack view that is scrollable if the content size exceeds the frame size
final class ScrollableStackView: UIView {
    /// Scroll view
    let scrollView: UIScrollView

    /// Stack view
    let stackView: UIStackView

    init(arrangedSubviews: [UIView]) {
        scrollView = UIScrollView()
        stackView = UIStackView(arrangedSubviews: arrangedSubviews)

        super.init(frame: .zero)

        addEdgeMatchedSubview(scrollView)
        scrollView.addEdgeMatchedSubview(stackView)
        stackView.makeEqualWidth()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
