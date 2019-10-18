//
//  InfoEntryView.swift
//  ECE564_HOMEWORK
//
//  Created by Trevor Stevenson on 9/21/19.
//  Copyright © 2019 ece564. All rights reserved.
//

import UIKit

/// A view for displaying one piece of info about a person
final class InfoEntryView: UIView {
    /// If the user can only view information
    var viewOnly: Bool {
        didSet {
            textField.isUserInteractionEnabled = !viewOnly
            segmentedControl.isUserInteractionEnabled = !viewOnly
        }
    }

    /// The value of the input
    var value: String {
        return
            entryType == .textEntry ?
            textField.text ?? "" :
            options?[segmentedControl.selectedSegmentIndex] ?? ""
    }

    /// The type of entry
    /// textEntry: free type
    /// options: finite options list in segmented control
    enum EntryType {
        case textEntry
        case options
    }

    /// Title label for entry
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)

        return label
    }()

    /// Text field for free text input
    private lazy var textField: UITextField = {
        let field = UITextField()
        field.borderStyle = .roundedRect
        field.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        field.isUserInteractionEnabled = !viewOnly
        field.delegate = delegate

        return field
    }()

    /// Segmented control for selecting options
    private lazy var segmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: options)
        control.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        control.isUserInteractionEnabled = !viewOnly

        return control
    }()

    /// Horizontal stack view to hold content
    private lazy var contentStackView: UIStackView = {
        let stack = UIStackView(
            arrangedSubviews: [
                titleLabel,
                entryType == .textEntry ? textField : segmentedControl,
            ]
        )
        stack.spacing = .standard / 2
        stack.axis = .vertical

        return stack
    }()

    /// Title
    private let title: String

    /// Placeholder
    private let placeholder: String

    /// Options for the segmented control
    private var options: [String]?

    /// Default segment index
    private let index: Int

    /// Type of user input to save data
    private let entryType: EntryType

    /// Delegate
    private weak var delegate: UITextFieldDelegate?

    private init(
        title: String,
        placeholder: String = "",
        options: [String]? = nil,
        index: Int = 0,
        entryType: EntryType,
        delegate: UITextFieldDelegate,
        viewOnly: Bool = true
    ) {
        self.title = title
        self.placeholder = placeholder
        self.options = options
        self.index = index
        self.entryType = entryType
        self.delegate = delegate
        self.viewOnly = viewOnly

        super.init(frame: .zero)

        titleLabel.text = title
        addEdgeMatchedSubview(contentStackView)
        reset()

        setContentHuggingPriority(.defaultHigh, for: .vertical)
    }

    convenience init(
        title: String,
        placeholder: String,
        delegate: UITextFieldDelegate,
        viewOnly: Bool = true
    ) {
        self.init(
            title: title,
            placeholder: placeholder,
            options: nil,
            entryType: .textEntry,
            delegate: delegate,
            viewOnly: viewOnly
        )
    }

    convenience init(
        title: String,
        options: [String],
        index: Int,
        delegate: UITextFieldDelegate,
        viewOnly: Bool = true
    ) {
        self.init(
            title: title,
            options: options,
            index: index,
            entryType: .options,
            delegate: delegate,
            viewOnly: viewOnly
        )
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// Reset to default value
    func reset() {
        textField.placeholder = title
        if placeholder.count > 0 {
            textField.text = placeholder
        }

        segmentedControl.selectedSegmentIndex = index
    }
}
