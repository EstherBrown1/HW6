//
//  RosterCoordinator.swift
//  ECE564_HOMEWORK
//
//  Created by Trevor Stevenson on 9/21/19.
//  Copyright © 2019 ece564. All rights reserved.
//

import UIKit

/// Coordinator for the roster table view controller
final class RosterCoordinator: Coordinator {
    /// User defaults key for Duke people
    private let defaultsKey = "dukePeople"

    /// Initial directory
    private var initialDirectory: [DukePerson] {
        get {
            guard let data = UserDefaults.standard.value(forKey: defaultsKey) as? Data else {
                return baseDirectory.getAll()
            }

            let decoder = JSONDecoder()
            if let codingData = try? decoder.decode([DukePerson.CodingData].self, from: data) {
                return codingData.map { $0.person }
            }

            return baseDirectory.getAll()
        }
    }

    /// Roster table view controller
    private lazy var rosterTableViewController = RosterTableViewController(
        coordinator: self,
        initialRoster: initialDirectory
    )

    var childCoordinators: [Coordinator] = []

    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        if #available(iOS 11.0, *) {
            self.navigationController.navigationBar.prefersLargeTitles = true
            self.navigationController.navigationItem.largeTitleDisplayMode = .always
        }
        
        navigationController.pushViewController(rosterTableViewController, animated: true)
    }

    /// Add a new person to the roster
    func addPerson() {
        let informationViewController = InformationViewController(
            person: DukePerson(),
            coordinator: self,
            viewOnly: false
        )

        navigationController.pushViewController(informationViewController, animated: true)
    }

    /// Select an existing person
    func select(person: DukePerson, edit: Bool = false) {
        let informationViewController = InformationViewController(
            person: person,
            coordinator: self
        )

        if edit {
            informationViewController.edit()
        }

        navigationController.pushViewController(informationViewController, animated: true)
    }

    /// Save a new person
    func save(person: DukePerson) {
        rosterTableViewController.addToRoster(person)
        navigationController.popToRootViewController(animated: true)
    }

    /// Persist data to UserDefaults
    func persistData(_ data: [DukePerson.CodingData]) {
        let encoder = JSONEncoder()

        if let encodedData = try? encoder.encode(data) {
            UserDefaults.standard.setValue(encodedData, forKey: defaultsKey)
        }
    }
}
