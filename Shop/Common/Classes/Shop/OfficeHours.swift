//
//  OfficeHours.swift
//  Shop
//
//  Created by Nikulux on 30.11.2020.
//

import Foundation

struct OfficeHours {
	private var _opening: UInt
	var opening: UInt {
		set {
			if newValue > 24 || newValue >= self.closing {
				return
			}
			
			self._opening = newValue
		}
		
		get { self._opening }
	}
	
	private var _closing: UInt
	var closing: UInt {
		set {
			if newValue > 24 || newValue <= self.opening {
				return
			}
			
			self._closing = newValue
		}
		
		get { self._closing }
	}
	
	
}
