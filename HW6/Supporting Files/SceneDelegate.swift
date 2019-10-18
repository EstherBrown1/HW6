//
//  SceneDelegate.swift
//  HW6
//
//  Created by Trevor Stevenson on 10/17/19.
//  Copyright © 2019 CommunityService. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    /// Window of the application
    var window: UIWindow?

    /// Parent coordinator of the application
    var coordinator: Coordinator?

    func scene(_ scene: UIScene, willConnectTo _: UISceneSession, options _: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(windowScene: windowScene)
        let navigationController = UINavigationController()
        let mainCoordinator = MainCoordinator(navigationController: navigationController)

        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()

        mainCoordinator.start()

        coordinator = mainCoordinator
    }
}
