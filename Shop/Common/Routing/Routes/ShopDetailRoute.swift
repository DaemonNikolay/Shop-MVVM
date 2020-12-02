//
//  ShopDetailRoute.swift
//  Shop
//
//  Created by Nikulux on 02.12.2020.
//

import Foundation

protocol ShopDetailRoute {
	func showShopList()
}

extension ShopListRoute where Self: RouterProtocol {
	func showShopDetail() {
//		let module = ShopDetailModule()
//		let transition = WindowNavigationTransition()
//		
//		open(module.view, transition: transition)
	}
}
