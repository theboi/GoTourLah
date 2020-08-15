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

        let stallsVC = UINavigationController(rootViewController: StallsViewController())
		stallsVC.navigationBar.isTranslucent = true
		
        let exploreVC = UINavigationController(rootViewController: StallsViewController())
		
        let meVC = UINavigationController(rootViewController: StallsViewController())

		tabBarController.setViewControllers([stallsVC, exploreVC, meVC], animated: true)
		let images = ["bag", "magnifyingglass", "person.crop.circle"]
		let titles = ["Stalls", "Explore", "Me"]
		for (index, item) in tabBarController.tabBar.items?.enumerated() ?? [].enumerated() {
			item.image = UIImage(systemName: images[index])
			item.title = titles[index]
		}
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
	}
}

