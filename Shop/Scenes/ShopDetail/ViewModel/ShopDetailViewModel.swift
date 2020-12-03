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
	private let dataSource: DataSource = DataSource.shared
	
	init(container: Container) {
		self.router = container.router
		
		self.currentShop = self.dataSource.currentShop
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
																_ propertyValue: String?,
																_ propertyType: Shop.DetailNames?) -> Void) {
		
		let (propertyName, propertyValue) = self.propertyOfShopBy(numberRow)
		
		let title: String? = propertyName?.rawValue
		
		switch propertyName {
		case .type:
			completion(.popupShopType, title, propertyValue, propertyName)

		case .name:
			completion(.popupText, title, propertyValue, propertyName)
			
		case .employeesNumber:
			completion(.popupNumbers, title, propertyValue, propertyName)
			
		case .officeHours:
			completion(.showOperatingTime, nil, nil, nil)
			
		case .openingDate:
			print("-")
			
		default:
			print("~~~~~")
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
	
	func updateShop(shopDetailType: Shop.DetailNames, value: String, completion: @escaping () -> Void) {
		switch shopDetailType {
		case .name:
			self.updateNameOfShop(value)
		case .employeesNumber:
			guard let employees = UInt(value) else {
				return
			}
			
			self.updateEmployeesNumberOfShop(employees)
		case .type:
			guard let type = ShopType(rawValue: value) else {
				return
			}
			
			self.updateTypeOfShop(type)
		default:
			break
		}
		
		completion()
	}
	
	func updateNameOfShop(_ name: String) {
		self.currentShop?.name = name
	}
	
	func updateEmployeesNumberOfShop(_ number: UInt) {
		self.currentShop?.employeesNumber = number
	}
	
	func updateTypeOfShop(_ type: ShopType) {
		self.currentShop?.type = type
	}
	
	func saveShop(completion: @escaping () -> Void) {
		if let shop = self.currentShop {
			self.dataSource.updateShop(shop: shop)
		}
		
		completion()
	}
}

extension ShopDetailViewModel {
	struct Container {
		let router: ShopDetailRouter
	}
}
