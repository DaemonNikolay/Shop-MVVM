//
//  Shop.swift
//  Shop
//
//  Created by Nikulux on 30.11.2020.
//

import Foundation

class Shop: Codable {
	
	let id: UUID
	var type: ShopType
	var employeesNumber: UInt
	var openingDate: Date
	var name: String
	var officeHours: OfficeHours
	var isNearestShop: Bool

	init(type: ShopType,
		 employeesNumber: UInt,
		 openingDate: Date,
		 name: String,
		 officeHours: OfficeHours,
		 isNearestShop: Bool) {
		
		self.id = UUID()
		self.type = type
		self.employeesNumber = employeesNumber
		self.openingDate = openingDate
		self.name = name
		self.officeHours = officeHours
		self.isNearestShop = isNearestShop
	}
}

extension Shop {
	enum DetailNames: String, CaseIterable {
		case name = "Name"
		case type = "Type"
		case employeesNumber = "Employees number"
		case openingDate = "Opening date"
		case officeHours = "Office hours"
	}
}
