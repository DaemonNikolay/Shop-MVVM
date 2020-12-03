//
//  OfficeHours.swift
//  Shop
//
//  Created by Nikulux on 30.11.2020.
//

import Foundation
import os.log

struct OfficeHours: Codable {
	private var _opening: Float = .zero
	var opening: Float {
		set {
			let value = abs(newValue)
			
			if value > 24 {
				os_log("The opening time must be in the range from 0 to 24 and more closing time.",
					   log: .default,
					   type: .fault)
				
				return
			}
			
			self._opening = value
		}
		
		get { self._opening }
	}
	
	private var _closing: Float = .zero
	var closing: Float {
		set {
			let value = abs(newValue)
			
			if value > 24 {
				os_log("The closing time must be in the range from 0 to 24 and more opening time.",
					   log: .default,
					   type: .fault)
				
				return
			}
			
			self._closing = value
		}
		
		get { self._closing }
	}
	
	init(opening: Float, closing: Float) {
		self.opening = opening
		self.closing = closing
	}
}
