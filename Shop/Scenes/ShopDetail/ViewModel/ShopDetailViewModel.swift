//
//  ShopDetailViewModel.swift
//  Shop
//
//  Created by Nikulux on 30.11.2020.
//

import Foundation

struct ShopDetailViewModel {
	private let router: ShopDetailRouter
	
	let currentShop: Shop?
	
	init(container: Container) {
		self.router = container.router
		
		let dataSource = DataSource.shared
		self.currentShop = dataSource.currentShop
	}
	
	func propertyOfShopBy(_ index: Int) -> String {
		guard let currentShop = self.currentShop else {
			return "-"
		}
		
		let key: Shop.DetailNames = Shop.DetailNames.allCases[index]
		
		switch key {
		case .employeesNumber:
			return "\(key.rawValue): \(currentShop.employeesNumber)"
		case .type:
			return "\(key.rawValue): \(currentShop.type)"
		case .openingDate:
			return "\(key.rawValue): \(currentShop.openingDate)"
		case .name:
			return "\(key.rawValue): \(currentShop.name)"
		case .officeHours:
			return "\(key.rawValue): \(currentShop.officeHours.opening):\(currentShop.officeHours.closing)"
		}
	}
}

extension ShopDetailViewModel {
	struct Container {
		let router: ShopDetailRouter
	}
}
