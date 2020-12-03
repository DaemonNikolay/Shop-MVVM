//
//  OperatingTimeViewModel.swift
//  Shop
//
//  Created by Nikulux on 30.11.2020.
//

import Foundation

struct OperatingTimeViewModel {
	private let router: OperatingTimeRouter
	
	var currentShopOperatingTime: OfficeHours?
	var currentShop: Shop?
	let dataSource: DataSource = DataSource.shared
	
	init(container: Container) {
		self.router = container.router
		
		self.currentShopOperatingTime = self.dataSource.currentShop?.officeHours
		self.currentShop = self.dataSource.currentShop
	}
	
	func updateOpeningTimeOf(_ date: Date) {
		let timeFormatString = self.extractFormatTimeOf(date)
		if let openingTime: Float = Float(timeFormatString) {
			self.currentShop?.officeHours.opening = openingTime
		}
	}
	
	func updateClosingTimeOf(_ date: Date) {
		let timeFormatString = self.extractFormatTimeOf(date)
		if let closingTime: Float = Float(timeFormatString) {
			self.currentShop?.officeHours.closing = closingTime
		}
	}
	
	func updateCurrentShop() {
		if let shop = self.currentShop {
			self.dataSource.updateShop(shop: shop)
		}
		
		self.showShopList()
	}
	
	func showShopList() {
		self.router.showShopList()
	}
	
	private func extractFormatTimeOf(_ date: Date) -> String {
		let calendar = Calendar.current
		let hour = calendar.component(.hour, from: date)
		let minutes = calendar.component(.minute, from: date)
		
		return "\(hour).\(minutes)"
	}
}

extension OperatingTimeViewModel {
	struct Container {
		let router: OperatingTimeRouter
	}
}
