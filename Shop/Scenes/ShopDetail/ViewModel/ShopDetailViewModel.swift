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
	
	func propertyOfShopBy(_ index: Int) -> (Shop.DetailNames?, String) {
		guard let currentShop = self.currentShop else {
			return (nil, "-")
		}
		
		let key: Shop.DetailNames = Shop.DetailNames.allCases[index]
		var value: String
		
		switch key {
		case .employeesNumber:
			value = currentShop.employeesNumber.description
		case .type:
			value = currentShop.type.rawValue
		case .openingDate:
			value = currentShop.openingDate.description
		case .name:
			value = currentShop.name
		case .officeHours:
			value = "\(currentShop.officeHours.opening):\(currentShop.officeHours.closing)"
		}
		
		return (key, value)
	}
	
	func formatPropertyOfShopBy(_ index: Int) -> String {
		let (key, value) = self.propertyOfShopBy(index)
		
		return "\(key?.rawValue ?? "-"): \(value)"
	}
}

extension ShopDetailViewModel {
	struct Container {
		let router: ShopDetailRouter
	}
}
