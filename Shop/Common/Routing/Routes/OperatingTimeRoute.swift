//
//  OperatingTimeRoute.swift
//  Shop
//
//  Created by Nikulux on 03.12.2020.
//

import Foundation

protocol OperatingTimeRoute {
	func showOperatingTime()
}

extension OperatingTimeRoute where Self: RouterProtocol {
	func showOperatingTime() {
		let transition = WindowNavigationTransition()
		let module = OperatingTimeModule(transition: transition)
		
		open(module.view, transition: transition)
	}
}
