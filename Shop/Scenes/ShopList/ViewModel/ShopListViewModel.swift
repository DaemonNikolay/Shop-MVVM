import Foundation
import UIKit

// MARK: - Protocols

protocol ShopListViewModelInput {
	func didTapCellOf(_ tableView: UITableView, indexPath: IndexPath)
	func keyOfShopOffsetBy(_ offsetBy: Int) -> String
}

protocol ShopListViewModelOutput {
	func rowsCount() -> Int
	func numberOfRowsIn(_ section: Int) -> Int
	func fillCellIn(_ indexPath: IndexPath) -> UITableViewCell
	func titleForHeaderIn(_ section: Int) -> String?
}

// MARK: - ViewModel

struct ShopListViewModel {
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

// MARK: - Input

extension ShopListViewModel: ShopListViewModelInput {
	func didTapCellOf(_ tableView: UITableView, indexPath: IndexPath) {
		guard let name = tableView.cellForRow(at: indexPath)?.textLabel?.text else { return }
		
		let key = keyOfShopOffsetBy(indexPath.section)
		
		showShopDetail(shopName: name, shopType: key)
	}
	
	func keyOfShopOffsetBy(_ offsetBy: Int) -> String {
		let startIndex = shops.startIndex
		let index = shops.index(startIndex, offsetBy: offsetBy)
		let key = shops.keys[index]
		
		return key
	}
}

// MARK: - DI container

extension ShopListViewModel {
	struct Container {
		let router: ShopListRouter
	}
}
