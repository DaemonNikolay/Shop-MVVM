import Foundation

protocol ShopListRoute {
	func showShopList()
}

extension ShopListRoute where Self: RouterProtocol {
	func showShopList() {
		let transition = WindowNavigationTransition()
		let module = ShopListModule(transition: transition)
		
		open(module.view, transition: transition)
	}
}
