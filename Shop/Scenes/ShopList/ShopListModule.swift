//
//  ShopListModule.swift
//  Shop
//
//  Created by Nikulux on 02.12.2020.
//

import Foundation
import UIKit

struct ShopListModule {
	let view: UIViewController
	let router: ShopListRouter
	
	init(transition: Transition) {
		self.router = ShopListRouter()
		
		let viewModel = ShopListViewModel(container: .init(router: self.router))
		let view = ShopListViewController(container: .init(viewModel: viewModel))
		
		router.viewController = view
		router.openTransition = transition
		
		self.view = view
	}
}
