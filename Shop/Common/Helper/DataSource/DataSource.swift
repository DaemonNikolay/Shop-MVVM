//
//  DataSource.swift
//  Shop
//
//  Created by Nikulux on 30.11.2020.
//

import Foundation

class DataSource {
	private let keyShopIds: String = "shops"
	
	static var shared: DataSource = {
		let dataSource = DataSource()
		
		return dataSource
	}()
	
	private let dataSource: UserDefaults
	
	private init() {
		self.dataSource = UserDefaults.standard
	}
	
	var currentShop: Shop?
	
	var shopCount: Int {
		get {
			let shopIds = self.getShopIds()
			
			return shopIds?.count ?? 0
		}
	}
	
	func addShop(shop: Shop) {
		try? self.dataSource.setObject(shop, forKey: shop.id.description)
		
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
		guard let shop = try? dataSource.getObject(forKey: id, castTo: Shop.self) else {
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
		guard var shopIds = self.getShopIds() else {
			let shopIds = [id]
			self.dataSource.setValue(shopIds, forKey: self.keyShopIds)
			
			return
		}
		
		shopIds.append(id)
		self.dataSource.setValue(shopIds, forKey: self.keyShopIds)
	}
}

extension DataSource: NSCopying {
	func copy(with zone: NSZone? = nil) -> Any {
		return self
	}
}
