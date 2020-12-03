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
	
	init(container: Container) {
		self.router = container.router
		
		let dataSource = DataSource.shared
		self.currentShopOperatingTime = dataSource.currentShop?.officeHours
	}
	
	func showShopList() {
		self.router.showShopList()
	}
}

extension OperatingTimeViewModel {
	struct Container {
		let router: OperatingTimeRouter
	}
}
