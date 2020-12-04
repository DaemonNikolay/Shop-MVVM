//
//  ShopDetailModule.swift
//  Shop
//
//  Created by Nikulux on 03.12.2020.
//

import Foundation
import UIKit

struct ShopDetailModule {
	let view: UIViewController
	
	init(transition: Transition) {
		let router = ShopDetailRouter()
		
		let viewModel = ShopDetailViewModel(container: .init(router: router))
		let view = ShopDetailViewController(container: .init(viewModel: viewModel))
		
		router.viewController = view
		router.openTransition = transition
		
		self.view = view
	}
}
