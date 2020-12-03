//
//  OperatingTimeModule.swift
//  Shop
//
//  Created by Nikulux on 03.12.2020.
//

import UIKit

class OperatingTimeModule {
	let view: UIViewController
	let router: OperatingTimeRouter
	
	init(transition: Transition) {
		self.router = OperatingTimeRouter()
		
		let viewModel = OperatingTimeViewModel(container: .init(router: self.router))
		let view = OperatingTimeViewController(container: .init(viewModel: viewModel))
		
		self.router.viewController = view
		self.router.openTransition = transition
		
		self.view = view
	}
}
