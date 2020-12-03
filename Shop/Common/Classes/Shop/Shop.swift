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
	
	private enum CodingKeys: String, CodingKey {
		case id
		case type
		case employeesNumber
		case openingDate
		case name
		case officeHours
	}
	
	required init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		
		self.id = try values.decode(UUID.self, forKey: .id)
		self.type = try values.decode(ShopType.self, forKey: .type)
		self.employeesNumber = try values.decode(UInt.self, forKey: .employeesNumber)
		self.openingDate = try values.decode(Date.self, forKey: .openingDate)
		self.name = try values.decode(String.self, forKey: .name)
		self.officeHours = try values.decode(OfficeHours.self, forKey: .officeHours)
	}
	
	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		
		try container.encode(self.id, forKey: .id)
		try container.encode(self.type, forKey: .type)
		try container.encode(self.employeesNumber, forKey: .employeesNumber)
		try container.encode(self.openingDate, forKey: .openingDate)
		try container.encode(self.name, forKey: .name)
		try container.encode(self.officeHours, forKey: .officeHours)
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
