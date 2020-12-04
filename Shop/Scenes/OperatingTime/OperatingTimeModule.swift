//
//  OperatingTimeModule.swift
//  Shop
//
//  Created by Nikulux on 03.12.2020.
//

import UIKit

class OperatingTimeModule {
	let view: UIViewController
	
	init(transition: Transition) {
		let router = OperatingTimeRouter()
		
		let viewModel = OperatingTimeViewModel(container: .init(router: router))
		let view = OperatingTimeViewController(container: .init(viewModel: viewModel))
		
		router.viewController = view
		router.openTransition = transition
		
		self.view = view
	}
}
