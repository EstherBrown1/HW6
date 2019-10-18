//
//  RosterTableViewController.swift
//  ECE564_HOMEWORK
//
//  Created by Trevor Stevenson on 9/21/19.
//  Copyright © 2019 ece564. All rights reserved.
//

import UIKit

/// Table view to display class roster
final class RosterTableViewController: UITableViewController {
    /// Single list of people
    private var flatRoster: [DukePerson]

    /// Filtered single list of people
    private var filteredFlatRoster: [DukePerson] {
        didSet {
            segment()
        }
    }

    /// All team names
    private var teamNames: [String] {
        return flatRoster.compactMap { $0.team }.sorted()
    }

    /// Search controller
    private lazy var searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: nil)
        controller.searchResultsUpdater = self
        controller.searchBar.sizeToFit()

        definesPresentationContext = true

        return controller
    }()

    /// List of people
    private var roster: [[DukePerson]]

    /// Directory of people
    private var directory: DukeDirectory = baseDirectory

    /// Coordinator
    private weak var coordinator: RosterCoordinator?

    init(coordinator: RosterCoordinator, initialRoster: [DukePerson]) {
        self.coordinator = coordinator
        self.roster = []
        self.flatRoster = initialRoster
        self.filteredFlatRoster = initialRoster

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Class Roster"
        tableView.separatorStyle = .none
        tableView.tableHeaderView = searchController.searchBar

        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(add)
        )

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(persist),
            name: UIApplication.willResignActiveNotification,
            object: nil
        )

        // Segment the roster into sections and reload table
        segment()
        tableView.setNeedsDisplay()
        tableView.reloadData()
    }

    private func segment() {
        roster = filteredFlatRoster.segment { person in
            let role = DukeRole.allCases.firstIndex(of: person.role) ?? 0
            guard person.role == .Student else {
                return role
            }

            if let teamName = person.team {
                return role + (teamNames.firstIndex(of: teamName) ?? -1) + 1
            }

            return role
        }
        roster.removeAll { $0.isEmpty }
        tableView.reloadData()
    }

    @objc private func persist() {
        coordinator?.persistData(roster.flatMap { $0.map { $0.codingData } })
    }

    /// Select the add button
    @objc private func add() {
        coordinator?.addPerson()
    }

    /// Add a new person to the roster
    func addToRoster(_ person: DukePerson) {
        directory.add(person)
        flatRoster = directory.getAll()
        filteredFlatRoster = flatRoster
    }
}

// MARK: - Table view data source

extension RosterTableViewController {
    override func numberOfSections(in _: UITableView) -> Int {
        return roster.count
    }

    override func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        return roster[section].count
    }

    override func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return PersonTableViewCell(
            person: roster[indexPath.section][indexPath.row]
        )
    }

    override func tableView(_: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionHeader = UIView()
        sectionHeader.backgroundColor = .white

        let label = UILabel()
        let person = roster[section].first
        label.text = person?.role == .Student
            ? (person?.team ?? ("Student"))
            : (person?.role.rawValue ?? "")
        label.font = UIFont.boldSystemFont(ofSize: 24)

        sectionHeader.addSubview(label)
        label.pinLeft(inset: .standard)
        label.pinTop(inset: .standard / 4)
        label.pinBottom(inset: .standard / 4)

        return sectionHeader
    }
}

// MARK: - Table View Delegate

extension RosterTableViewController {
    private func editRow(at indexPath: IndexPath) {
        coordinator?.select(
            person: roster[indexPath.section][indexPath.row],
            edit: true
        )
    }
    override func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator?.select(person: roster[indexPath.section][indexPath.row])
    }

    @available(iOS 11.0, *)
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editTitle = NSLocalizedString("Edit", comment: "edit")
        let editAction = UIContextualAction(
            style: .normal,
            title: editTitle,
            handler: { [weak self] (action, view, completionHandler) in
                self?.editRow(at: indexPath)
                completionHandler(true)
            }
        )

        editAction.image = UIImage(named: "edit")
        editAction.backgroundColor = .black

        let deleteTitle = NSLocalizedString("Delete", comment: "delete")
        let deleteAction = UIContextualAction(
            style: .normal,
            title: deleteTitle,
            handler: { [weak self] (action, view, completionHandler) in
                guard let strongSelf = self else {
                    completionHandler(false)
                    return
                }

                let person = strongSelf.roster[indexPath.section][indexPath.row]
                strongSelf.directory.remove("\(person.firstName) \(person.lastName)")
                strongSelf.roster[indexPath.section].remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                strongSelf.flatRoster.removeAll { $0 == person }

                completionHandler(true)
            }
        )

        deleteAction.image = UIImage(named: "delete")
        deleteAction.backgroundColor = .red

        return UISwipeActionsConfiguration(
            actions: [deleteAction, editAction]
        )
    }
}

extension RosterTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            filteredFlatRoster = searchText.isEmpty ? flatRoster : flatRoster.filter(
                { (person: DukePerson) -> Bool in
                return
                    person.description.contains(searchText) ||
                    person.team?.contains(searchText) ?? false ||
                    person.gender.rawValue.contains(searchText) ||
                    person.degree?.rawValue.contains(searchText) ?? false
            })
        }
    }
}
