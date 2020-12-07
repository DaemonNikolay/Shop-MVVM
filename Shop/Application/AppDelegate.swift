//
//  AppDelegate.swift
//  Shop
//
//  Created by Nikulux on 30.11.2020.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
	
	var window: UIWindow?
	
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		// Override point for customization after application launch.
		
		beginUserStory()
		
		return true
	}
	
	private func autoFillDB() {
		AutoFillDB.autoFillDBFrom(4)
	}
	
	private func beginUserStory() {
		let window = UIWindow()
		self.window = window
		
		autoFillDB()
		
		AppRouter().showShopList()
	}
}

