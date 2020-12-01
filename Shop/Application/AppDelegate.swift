//
//  AppDelegate.swift
//  Shop
//
//  Created by Nikulux on 30.11.2020.
//

import UIKit
import Fakery

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		// Override point for customization after application launch.
		
		self.autoFillDB()
		
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


	private func autoFillDB() {
		let dataSource = DataSource.shared
		let shops = dataSource.shops()
		if dataSource.shopCount > 0 {
			return
		}
		
		let faker = Faker(locale: "en")
		
		let shopTypes = ShopType.allCases
		for i in 0...shopTypes.count-1 {
			for _ in 0...4 {
				let officeHours = OfficeHours(opening: 8, closing: 20)
				let shop: Shop = Shop(type: shopTypes[i],
									  employeesNumber: UInt(faker.number.randomInt(min: 1, max: 9999)),
									  openingDate: faker.date.forward(99999),
									  name: faker.company.name(),
									  officeHours: officeHours)
				
				dataSource.addShop(shop: shop)
			}
		}
	}
}

