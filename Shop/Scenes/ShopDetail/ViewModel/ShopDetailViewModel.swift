//
//  ShopDetailViewModel.swift
//  Shop
//
//  Created by Nikulux on 30.11.2020.
//

import Foundation

struct ShopDetailViewModel: ShopDetailViewModelInput {
	private let router: ShopDetailRouter
	private let dataSource: DataSource = DataSource.shared
	
	let currentShop: Shop?
	
	init(container: Container) {
		router = container.router
		currentShop = dataSource.currentShop
	}
	
	func formatPropertyOfShopBy(_ index: Int) -> (String, Shop.DetailNames?) {
		guard let currentShop = currentShop else { return ("-", nil) }
		
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
		
		return ("\(key.rawValue): \(value)", key)
	}
	
	func showOperatingTime() {
		router.showOperatingTime()
	}
	
	func showShopList() {
		router.showShopList()
	}
	
	func updateShop(shopDetailType: Shop.DetailNames, value: String, completion: @escaping () -> Void) {
		switch shopDetailType {
		case .name:
			updateNameOfShop(value)
		case .employeesNumber:
			guard let employees = UInt(value) else { return }
			
			updateEmployeesNumberOfShop(employees)
		case .type:
			guard let type = ShopType(rawValue: value) else { return }
			
			updateTypeOfShop(type)
		default:
			break
		}
		
		completion()
	}
	
	func updateNameOfShop(_ name: String) {
		currentShop?.name = name
	}
	
	func updateEmployeesNumberOfShop(_ number: UInt) {
		currentShop?.employeesNumber = number
	}
	
	func updateTypeOfShop(_ type: ShopType) {
		currentShop?.type = type
	}
	
	func saveShop(completion: @escaping () -> Void) {
		if let shop = currentShop {
			dataSource.updateShop(shop: shop)
		}
		
		completion()
	}
}

extension ShopDetailViewModel {
	struct Container {
		let router: ShopDetailRouter
	}
}
