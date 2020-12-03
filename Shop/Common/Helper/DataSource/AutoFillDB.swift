//
//  AutoFillDB.swift
//  Shop
//
//  Created by Nikulux on 01.12.2020.
//

import Foundation
import Fakery

final class AutoFillDB {
	static func autoFillDBFrom(_ numberElementsOfOneType: UInt) {
		let dataSource = DataSource.shared
		if dataSource.shopCount > 0 {
			return
		}
		
		let faker = Faker(locale: "en")
		
		let shopTypes = ShopType.allCases
		for i in 0...shopTypes.count-1 {
			for j in 0...numberElementsOfOneType {
				let officeHours = OfficeHours(opening: 8, closing: 20)
				let shop: Shop = Shop(type: shopTypes[i],
									  employeesNumber: UInt(faker.number.randomInt(min: 1, max: 9999)),
									  openingDate: faker.date.forward(99999),
									  name: faker.company.name(),
									  officeHours: officeHours,
									  isNearestShop: i == j ? true : false)
				
				dataSource.addShop(shop: shop)
			}
		}
	}
}
