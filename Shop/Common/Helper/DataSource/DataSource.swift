//
//  DataSource.swift
//  Shop
//
//  Created by Nikulux on 30.11.2020.
//

import Foundation

struct DataSource {
	private let keyShop: String = "shop"
	
	static var shared: DataSource {
		let dataSource = DataSource()
		
		return dataSource
	}
	
	private init() {
		
	}
	
	var shopCount: Int {
		get {
			let userDefaults = UserDefaults.standard
			let shops = userDefaults.array(forKey: self.keyShop)
			
			return shops?.count ?? 0
		}
	}
	
	func addShop(shop: Shop) {
		let userDefaults = UserDefaults.standard
		
		guard var oldShops = userDefaults.array(forKey: self.keyShop) as? [Shop] else {
			userDefaults.setValue([shop], forKey: self.keyShop)
			
			return
		}
		
		oldShops.append(shop)
	}
	
	func shops() -> Array<Shop>? {
		let userDefaults = UserDefaults.standard
		let shops: Array<Shop>? = userDefaults.array(forKey: self.keyShop) as? Array<Shop>
			
		return shops
	}
	
	func shop(id: UUID) -> Shop? {
		guard let shops = self.shops() else {
			return nil
		}
		
		if let shop = shops.first(where: { $0.id == id }) {
			return shop
		}
		
		return nil
	}
}
