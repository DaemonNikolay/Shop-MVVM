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
	private var _shops: ShopData = [:]
	var shops: ShopData {
		set {
			self._shops = newValue
		}
		mutating get {
			if self._shops.isEmpty {
				self.shopsUpdate()
			}
			
			return self._shops
		}
	}
	
	init(container: Container) {
		self.router = container.router
		
		self.shopsUpdate()
	}
	
	
	mutating func shopsUpdate() {
		let dataSource = DataSource.shared

		guard let shops = dataSource.shops() else {
			return
		}
		
		var result = ShopType.AllCases().map { shopType -> ShopData in
			[shopType.rawValue: []]
		}
		
		print(result)
		
		shops.forEach { shop in
			
		}
	}
}

extension ShopListViewModel {
	struct Container {
		let router: ShopListRouter
	}
}
