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
	
	func actionOnCellTap(numberRow: Int, completion: @escaping (_ type: ActionType,
																_ propertyName: String?,
																_ propertyValue: String?) -> Void) {
		
		let (propertyName, propertyValue) = self.propertyOfShopBy(numberRow)
		
		let title: String? = propertyName?.rawValue
		
		switch propertyName {
		case .type:
			completion(.popupShopType, title, propertyValue)

		case .name:
			completion(.popupText, title, propertyValue)
			
		case .employeesNumber:
			print("-")
			
		case .officeHours:
			completion(.showOperatingTime, nil, nil)
			
		case .openingDate:
			print("-")
			
		default:
			print("-")
		}
	}
	
	func formatPropertyOfShopBy(_ index: Int) -> String {
		let (key, value) = self.propertyOfShopBy(index)
		
		return "\(key?.rawValue ?? "-"): \(value)"
	}
	
	func showOperatingTime() {
		self.router.showOperatingTime()
	}
	
	func showShopList() {
		self.router.showShopList()
	}
}

extension ShopDetailViewModel {
	struct Container {
		let router: ShopDetailRouter
	}
}
