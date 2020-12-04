//
//  OfficeHours.swift
//  Shop
//
//  Created by Nikulux on 30.11.2020.
//

import Foundation
import os.log

struct OfficeHours: Codable {
	private let timeLimit: Float = 24.59
	
	var opening: Float = .zero {
		didSet {
			let value = abs(opening)

			if value > timeLimit {
				os_log("The opening time must be in the range from 0 to 24 and more closing time.",
					   log: .default,
					   type: .fault)

				opening = oldValue
			}
		}
	}
	
	var closing: Float = .zero {
		didSet {
			let value = abs(closing)
			
			if value > timeLimit {
				os_log("The closing time must be in the range from 0 to 24 and more opening time.",
					   log: .default,
					   type: .fault)
				
				closing = oldValue
			}
		}
	}
	
	init(opening: Float, closing: Float) {
		self.opening = opening
		self.closing = closing
	}
}
