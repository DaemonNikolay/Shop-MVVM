//
//  OfficeHours.swift
//  Shop
//
//  Created by Nikulux on 30.11.2020.
//

import Foundation
import os.log

struct OfficeHours: Codable {
	private var _opening: UInt = .min
	var opening: UInt {
		set {
			if newValue > 24 {
				os_log("The opening time must be in the range from 0 to 24 and more closing time.",
					   log: .default,
					   type: .fault)
				
				return
			}
			
			self._opening = newValue
		}
		
		get { self._opening }
	}
	
	private var _closing: UInt = .min
	var closing: UInt {
		set {
			if newValue > 24 {
				os_log("The closing time must be in the range from 0 to 24 and more opening time.",
					   log: .default,
					   type: .fault)
				
				return
			}
			
			self._closing = newValue
		}
		
		get { self._closing }
	}
	
	init(opening: UInt, closing: UInt) {
		self.opening = opening
		self.closing = closing
	}
}
