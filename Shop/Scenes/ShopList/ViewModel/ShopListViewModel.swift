import Foundation

protocol ShopListViewModelInput { }

protocol ShopListViewModelOutput { }

struct ShopListViewModel: ShopListViewModelInput {
	private let router: ShopListRouter
	
	typealias ShopData = [String: [Shop]]
	
	var shops: ShopData = [:]
	
	init(container: Container) {
		router = container.router
		shops = shopsInit()
	}
	
	func shopsInit() -> ShopData {
		let dataSource = DataSource.shared
		guard let shops = dataSource.shops() else {	return [:] }
		
		var result: ShopData = [:]
		
		ShopType.allCases.forEach { shopType in
			result[shopType.rawValue] = []
		}
		
		shops.forEach { shop in
			let key: String = shop.type.rawValue
			result[key]?.append(shop)
		}
		
		return result
	}
	
	func shop(name: String, key: String) -> Shop? {
		let shop = shops[key]?.first(where: { $0.name == name })
		
		return shop
	}
	
	func showShopDetail(shopName: String, shopType: String) {
        guard let shop = shop(name: shopName, key: shopType), let isNearestShop = shop.isNearestShop else { return	}

		let dataSource = DataSource.shared
		dataSource.currentShop = shop
		
        if !isNearestShop {
			transitionToShopDetail()
		} else {
			transitionToShopOperatingTime()
		}
	}
	
	private func transitionToShopOperatingTime() {
		router.showOperatingTime()
	}
	
	private func transitionToShopDetail() {
		router.showShopDetail()
	}
}

extension ShopDetailViewModelInput { }

// MARK: - DI container

extension ShopListViewModel {
	struct Container {
		let router: ShopListRouter
	}
}
