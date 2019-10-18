//
//  InformationViewController.swift
//  ECE564_HOMEWORK
//
//  Created by Trevor Stevenson on 9/21/19.
//  Copyright © 2019 ece564. All rights reserved.
//

import UIKit

/// A view controller to display info about a person
final class InformationViewController: UIViewController {
    /// Info entries
    private lazy var firstName = InfoEntryView(
        title: "First Name",
        placeholder: person.firstName,
        delegate: self,
        viewOnly: viewOnly
    )

    private lazy var lastName = InfoEntryView(
        title: "Last Name",
        placeholder: person.lastName,
        delegate: self,
        viewOnly: viewOnly
    )

    private lazy var gender = InfoEntryView(
        title: "Gender",
        options: Gender.allValues,
        index: Gender.allCases.firstIndex(of: person.gender) ?? 0,
        delegate: self,
        viewOnly: viewOnly
    )

    private lazy var role = InfoEntryView(
        title: "Role",
        options: DukeRole.allValues,
        index: DukeRole.allCases.firstIndex(of: person.role) ?? 0,
        delegate: self,
        viewOnly: viewOnly
    )

    private lazy var team = InfoEntryView(
        title: "Team",
        placeholder: person.team ?? "",
        delegate: self,
        viewOnly: viewOnly
    )

    private lazy var from = InfoEntryView(
        title: "From",
        placeholder: person.whereFrom,
        delegate: self,
        viewOnly: viewOnly
    )

    private lazy var degree = InfoEntryView(
        title: "Degree",
        options: DukeDegree.allValues,
        index: DukeDegree.allCases.firstIndex(of: person.degree ?? .bachelors) ?? 0,
        delegate: self,
        viewOnly: viewOnly
    )

    private lazy var hobbies = InfoEntryView(
        title: "Hobbies",
        placeholder: person.hobbies.joined(separator: ", "),
        delegate: self,
        viewOnly: viewOnly
    )

    private lazy var languages = InfoEntryView(
        title: "Languages",
        placeholder: person.languages.joined(separator: ", "),
        delegate: self,
        viewOnly: viewOnly
    )

    private lazy var avatarImageStackView: UIStackView = {
        let avatar = CircleImageView()
        avatar.image = person.picture
        avatar.size = view.bounds.width / 3

        let stack = UIStackView(
            arrangedSubviews: [
                UIView(),
                avatar,
                UIView(),
            ]
        )
        stack.distribution = .equalSpacing

        return stack
    }()

    /// View hobbies button
    private lazy var hobbiesButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("View Hobbies", for: .normal)
        button.tapHandler = { [weak self] in
            let hobbiesViewController = HobbyViewController()
            hobbiesViewController.modalTransitionStyle = .flipHorizontal
            self?.present(hobbiesViewController, animated: true, completion: nil)
        }

        return button
    }()

    /// Save button
    private lazy var saveButton: RoundedButton = {
        let button = RoundedButton(text: "Save", color: .darkGray)
        button.tapHandler = { [weak self] in
            guard let strongSelf = self else {
                return
            }

            guard
                strongSelf.firstName.value.count > 0,
                strongSelf.lastName.value.count > 0
            else {
                let alert = UIAlertController(
                    title: "Invalid Input",
                    message: "Please make sure you enter a first and last name.",
                    preferredStyle: .alert
                )
                alert.addAction(
                    UIAlertAction(
                        title: "Ok",
                        style: .cancel,
                        handler: nil
                    )
                )
                strongSelf.present(alert, animated: true, completion: nil)
                return
            }

            strongSelf.person.firstName = strongSelf.firstName.value
            strongSelf.person.lastName = strongSelf.lastName.value
            strongSelf.person.whereFrom = strongSelf.from.value

            if strongSelf.team.value.count > 0 {
                strongSelf.person.team = strongSelf.team.value
            }

            strongSelf.person.gender = Gender(
                rawValue: strongSelf.gender.value
            ) ?? .Male

            strongSelf.person.dukeRole = DukeRole(
                rawValue: strongSelf.role.value
            ) ?? .Student

            strongSelf.person.dukeDegree = DukeDegree(
                rawValue: strongSelf.degree.value
            ) ?? .bachelors

            strongSelf.person.dukeHobbies = strongSelf.hobbies.value.components(separatedBy: ",")
            strongSelf.person.programmingLanguages = strongSelf.languages.value.components(separatedBy: ",")

            if strongSelf.title == "New Person" {
                strongSelf.person.avatar = UIImage(
                    named: "avatar\(Int.random(in: 1 ... 5))"
                ) ?? UIImage()
            }

            strongSelf.coordinator?.save(person: strongSelf.person)
        }
        button.makeHeight(3 * .standard)

        return button
    }()

    /// Dismiss/Save button stack view
    private lazy var buttonStackView: UIStackView = {
        let stack = UIStackView(
            arrangedSubviews: [saveButton]
        )
        stack.spacing = .standard / 2
        stack.distribution = .fillEqually

        saveButton.isHidden = viewOnly

        return stack
    }()

    private lazy var entriesStackView: ScrollableStackView = {
        let stack = ScrollableStackView(
            arrangedSubviews: [
                firstName,
                lastName,
                gender,
                role,
                team,
                from,
                degree,
                hobbies,
                languages,
                avatarImageStackView,
                person.hasAnimatedHobby ? hobbiesButton : UIView()
            ]
        )
        stack.stackView.axis = .vertical
        stack.stackView.spacing = .standard / 2

        return stack
    }()

    /// Active text field
    private var activeTextField: UITextField?

    /// Person whose info is displayed
    private let person: DukePerson

    /// If the properties are view only
    private var viewOnly: Bool {
        didSet {
            gender.viewOnly = viewOnly
            role.viewOnly = viewOnly
            team.viewOnly = viewOnly
            from.viewOnly = viewOnly
            degree.viewOnly = viewOnly
            hobbies.viewOnly = viewOnly
            languages.viewOnly = viewOnly

            saveButton.isHidden = viewOnly
        }
    }

    /// Coordinator
    private weak var coordinator: RosterCoordinator?

    init(person: DukePerson, coordinator: RosterCoordinator, viewOnly: Bool = true) {
        self.person = person
        self.coordinator = coordinator
        self.viewOnly = viewOnly

        super.init(nibName: nil, bundle: nil)

        setupSubviews()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupSubviews() {
        let inset: CGFloat = .standard

        view.backgroundColor = .white

        view.addSubview(buttonStackView)
        buttonStackView.pinBottom(inset: inset)
        buttonStackView.pinLeft(inset: inset)
        buttonStackView.pinRight(inset: inset)

        view.addSubview(entriesStackView)
        if #available(iOS 11.0, *) {
            entriesStackView.topAnchor.makeEqual(view.safeAreaLayoutGuide.topAnchor, constant: inset)
        } else {
            entriesStackView.pinTop(inset: inset)
        }

        entriesStackView.pinLeft(inset: inset)
        entriesStackView.pinRight(inset: inset)
        entriesStackView.bottomAnchor.makeEqual(buttonStackView.topAnchor, constant: -.standard)
    }

    override func viewDidLoad() {
        title = "\(person.firstName) \(person.lastName)"
        if person.firstName.count == 0, person.lastName.count == 0 {
            title = "New Person"
            avatarImageStackView.isHidden = true
        }

        if viewOnly {
            navigationItem.rightBarButtonItem = UIBarButtonItem(
                barButtonSystemItem: .edit,
                target: self,
                action: #selector(edit)
            )
        }

        // Dismiss keyboard on tap
        let tapToDismiss = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapToDismiss)

        // Shift view when keyboard shows and hides
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func edit() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))

        viewOnly = false
    }

    @objc private func cancel() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(edit))

        // Reset all inputs
        gender.reset()
        role.reset()
        team.reset()
        from.reset()
        degree.reset()
        hobbies.reset()
        languages.reset()

        buttonStackView.removeArrangedSubview(saveButton)
        saveButton.removeFromSuperview()
        viewOnly = true
    }
}

// MARK: - Keyboard and Textfield Delegate

extension InformationViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
    }

    func textFieldDidEndEditing(_: UITextField) {
        activeTextField = nil
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if
                let textField = activeTextField,
                textField.frame.origin.y + textField.frame.height > self.view.bounds.height - keyboardSize.height {
                view.frame.origin.y -= textField.frame.origin.y + textField.frame.height - (view.bounds.height - keyboardSize.height)
            }
        }
    }

    @objc func keyboardWillHide(notification _: NSNotification) {
        if view.frame.origin.y != 0 {
            view.frame.origin.y = 0
        }
    }

    @objc private func dismissKeyboard() {
        UIApplication.shared.sendAction(
            #selector(UIApplication.resignFirstResponder),
            to: nil,
            from: nil,
            for: nil
        )
    }
}
