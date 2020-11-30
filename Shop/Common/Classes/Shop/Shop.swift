//
//  Shop.swift
//  Shop
//
//  Created by Nikulux on 30.11.2020.
//

import Foundation

class Shop {
	let id: UUID
	var type: ShopType
	var employeesNumber: UInt
	var openingDate: Date
	var name: String
	var officeHours: OfficeHours

	init(type: ShopType,
		 employeesNumber: UInt,
		 openingDate: Date,
		 name: String,
		 officeHours: OfficeHours) {
		
		self.id = UUID()
		self.type = type
		self.employeesNumber = employeesNumber
		self.openingDate = openingDate
		self.name = name
		self.officeHours = officeHours
	}
}
