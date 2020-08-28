//
//  AppDelegate.swift
//  InnoFest
//
//  Created by Ryan The on 13/8/20.
//  Copyright © 2020 Ryan The. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

//	func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
//		
//		if let rootViewController = self.topViewControllerWithRootViewController(rootViewController: window?.rootViewController), rootViewController.responds(to: Selector(("canRotate"))) {
//			return .landscape;
//		}
//		return .allButUpsideDown;
//	}
//	
//	private func topViewControllerWithRootViewController(rootViewController: UIViewController!) -> UIViewController? {
//		guard rootViewController != nil else { return nil }
//
//		guard !(rootViewController.isKind(of: (UITabBarController).self)) else{
//			return topViewControllerWithRootViewController(rootViewController: (rootViewController as! UITabBarController).selectedViewController)
//		}
//		guard !(rootViewController.isKind(of:(UINavigationController).self)) else{
//			return topViewControllerWithRootViewController(rootViewController: (rootViewController as! UINavigationController).visibleViewController)
//		}
//		guard !(rootViewController.presentedViewController != nil) else{
//			return topViewControllerWithRootViewController(rootViewController: rootViewController.presentedViewController)
//		}
//		return rootViewController
//	}

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
		return true
	}

	// MARK: UISceneSession Lifecycle

	func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
		// Called when a new scene session is being created.
		// Use this method to select a configuration to create the new scene with.
		return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
	}

	func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
		// Called when the user discards a scene session.
		// If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
		// Use this method to release any resources that were specific to the discarded scenes, as they will not return.
	}


}
