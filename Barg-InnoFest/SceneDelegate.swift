//
//  SceneDelegate.swift
//  InnoFest
//
//  Created by Ryan The on 13/8/20.
//  Copyright © 2020 Ryan The. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?

	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		guard let windowScene = (scene as? UIWindowScene) else { return }
		window = UIWindow(frame: UIScreen.main.bounds)
		window?.windowScene = windowScene
		let tabBarController = UITabBarController(nibName: nil, bundle: nil)

        let exploreTab = UINavigationController(rootViewController: StallsViewController())

        let stallsTab = UINavigationController(rootViewController: StallsViewController())
		stallsTab.navigationBar.prefersLargeTitles = true
		
		let meTab = UINavigationController(rootViewController: SettingsViewController(list: nil))

		tabBarController.setViewControllers([exploreTab, stallsTab, meTab], animated: true)
		tabBarController.selectedIndex = 1
		let images = ["map", "bag", "person.crop.circle"]
		let titles = ["Explore", "Order", "Settings"]
		for (index, item) in tabBarController.tabBar.items!.enumerated() {
			item.image = UIImage(systemName: images[index])
			item.title = titles[index]
		}
		window?.tintColor = K.tintColor
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
	}
}
