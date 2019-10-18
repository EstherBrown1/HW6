//
//  MainCoordinator.swift
//  ECE564_HOMEWORK
//
//  Created by Trevor Stevenson on 9/21/19.
//  Copyright © 2019 ece564. All rights reserved.
//

import UIKit

/// Parent coordinator for the entire app
final class MainCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []

    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let rosterCoordinator = RosterCoordinator(navigationController: navigationController)

        childCoordinators.append(rosterCoordinator)
        rosterCoordinator.start()
    }
}
