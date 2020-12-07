import Foundation

protocol ShopDetailRoute {
	func showShopDetail()
}

extension ShopDetailRoute where Self: RouterProtocol {
	func showShopDetail() {
		let transition = WindowNavigationTransition()
		let module = ShopDetailModule(transition: transition)
		
		open(module.view, transition: transition)
	}
}
