//
//  ShopDetailModule.swift
//  Shop
//
//  Created by Nikulux on 03.12.2020.
//

import Foundation
import UIKit

class ShopDetailModule {
	let view: UIViewController
	let router: ShopDetailRouter
	
	init(transition: Transition) {
		self.router = ShopDetailRouter()
		
		let viewModel = ShopDetailViewModel(container: .init(router: self.router))
		let view = ShopDetailViewController(container: .init(viewModel: viewModel))
		
		self.router.viewController = view
		self.router.openTransition = transition
		
		self.view = view
	}
}
