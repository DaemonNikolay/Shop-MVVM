//
//  ShopListViewModel.swift
//  Shop
//
//  Created by Nikulux on 30.11.2020.
//

import Foundation

struct ShopListViewModel {
	private let router: ShopListRouter
	
	typealias ShopData = [String: [Shop]]
	
	var shops: ShopData = [:]
	
	init(container: Container) {
		self.router = container.router
		self.shops = self.shopsInit()
	}
	
	
	func shopsInit() -> ShopData {
		let dataSource = DataSource.shared
		guard let shops = dataSource.shops() else {
			return [:]
		}
		
		var result: ShopData = [:]
		
		ShopType.allCases.forEach { shopType in
			result[shopType.rawValue] = []
		}
		
		shops.forEach { shop in
			let key: String = shop.type.rawValue
			result[key]?.append(shop)
		}
		
		return result
	}
	
	func shop(name: String, key: String) -> Shop? {
		let shop = self.shops[key]?.first(where: { $0.name == name })
		
		return shop
	}
	
	func showShopDetail(shopName: String, shopType: String) {
		guard let shop = self.shop(name: shopName, key: shopType) else {
			return
		}
		
		var dataSource = DataSource.shared
		dataSource.currentShop = shop
		
		self.transitionToShopDetail()
	}
	
	private func transitionToShopDetail() {
		self.router.showShopDetail()
	}
}

extension ShopListViewModel {
	struct Container {
		let router: ShopListRouter
	}
}
