//
//  Date.swift
//  Shop
//
//  Created by Nikulux on 01.12.2020.
//

import Foundation

extension Date {
	
	/// https://gist.github.com/edmund-h/2638e87bdcc26e3ce9fffc0aede4bdad
	func generateRandomDate(daysBack: Int)-> Date? {
		let day = arc4random_uniform(UInt32(daysBack))+1
		let hour = arc4random_uniform(23)
		let minute = arc4random_uniform(59)
		
		let today = Date(timeIntervalSinceNow: 0)
		let gregorian  = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)
		var offsetComponents = DateComponents()
		offsetComponents.day = -1 * Int(day - 1)
		offsetComponents.hour = -1 * Int(hour)
		offsetComponents.minute = -1 * Int(minute)
		
		let randomDate = gregorian?.date(byAdding: offsetComponents, to: today, options: .init(rawValue: 0) )
		return randomDate
	}
}
