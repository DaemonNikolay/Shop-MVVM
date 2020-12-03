//
//  OperatingTimeViewModel.swift
//  Shop
//
//  Created by Nikulux on 30.11.2020.
//

import Foundation

struct OperatingTimeViewModel {
	private let router: OperatingTimeRouter
	
	init(container: Container) {
		self.router = container.router
	}
}

extension OperatingTimeViewModel {
	struct Container {
		let router: OperatingTimeRouter
	}
}
