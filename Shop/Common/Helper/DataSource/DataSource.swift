//
//  DataSource.swift
//  Shop
//
//  Created by Nikulux on 30.11.2020.
//

import Foundation

struct DataSource {
	private let keyShopIds: String = "shops"
	
	static var shared: DataSource {
		let dataSource = DataSource()
		
		return dataSource
	}
	
	private let dataSource: UserDefaults
	
	private init() {
		self.dataSource = UserDefaults.standard
	}
	
	
	var shopCount: Int {
		get {
			let shopIds = self.getShopIds()
			
			return shopIds?.count ?? 0
		}
	}
	
	func addShop(shop: Shop) {
		self.dataSource.setValue(shop, forKey: shop.id.description)
		self.updateShopIds(id: shop.id.description)
	}
	
	func shops() -> Array<Shop>? {
		guard let shopIds: Array<String> = self.getShopIds() else {
			return nil
		}

		let shops: Array<Shop> = shopIds.map { shopId in
			self.shop(id: shopId)!
		}
			
		return shops
	}
	
	func shop(id: String) -> Shop? {
		guard let shop = self.dataSource.object(forKey: id) as? Shop else {
			return nil
		}
		
		return shop
	}
	
	func updateShop(id: UUID, newShop: Shop) -> Bool {
		guard let _ = self.shop(id: id.description) else {
			return false
		}
		
		if newShop.id != id {
			self.dataSource.setValue(newShop, forKey: id.description)
			return true
		}

		return false
	}
	
	private func getShopIds() -> Array<String>? {
		let userDefaults = UserDefaults.standard
		let shopIds = userDefaults.array(forKey: self.keyShopIds) as? Array<String>
		
		return shopIds
	}
	
	private func updateShopIds(id: String) {
		var shopIds = self.getShopIds()
		shopIds?.append(id)
		
		self.dataSource.setValue(shopIds, forKey: self.keyShopIds)
	}
}
