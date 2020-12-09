import Foundation
import UIKit

// MARK: - Protocols

protocol ShopListViewModelInput {
	func didLoad()
	
	func didTapCellOf(_ tableView: UITableView, indexPath: IndexPath)
	func keyOfShopOffsetBy(_ offsetBy: Int) -> String
	
	func rowsCount() -> Int
	func numberOfRowsIn(_ section: Int) -> Int
	func fillCellBy(_ indexPath: IndexPath, tableView: UITableView, identifier: String) -> UITableViewCell
	func titleForHeaderIn(_ section: Int) -> String?
}

protocol ShopListViewModelOutput: class {
	func reloadShopsTable()
}

// MARK: - ViewModel

class ShopListViewModel {
	private let router: ShopListRouter
	private weak var view: ShopListViewModelOutput?
	
	typealias ShopData = [String: [Shop]]
	
	var shops: ShopData = [:]
	
	init(container: Container) {
		router = container.router
	}
	
	func setup(view: ShopListViewModelOutput) {
		self.view = view
	}
	
	func shopsInit() {
		let dataSource = DataSource.shared
		guard let shops = dataSource.shops() else {	return }
		
		var result: ShopData = [:]
		ShopType.allCases.forEach { shopType in
			result[shopType.rawValue] = []
		}
		
		shops.forEach { shop in
			let key: String = shop.type.rawValue
			result[key]?.append(shop)
		}
		
		self.shops = result
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
	func rowsCount() -> Int {
		shops.count
	}
	
	func numberOfRowsIn(_ section: Int) -> Int {
		let key: String = keyOfShopOffsetBy(section)
		
		return shops[key]?.count ?? 0
	}
	
	func fillCellBy(_ indexPath: IndexPath,
					tableView: UITableView,
					identifier: String) -> UITableViewCell {
		
		let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
		
		let key = keyOfShopOffsetBy(indexPath.section)
		guard let shops = shops[key] else {
			cell.textLabel?.text = "-"
			
			return cell
		}
		
		cell.textLabel?.text = shops[indexPath.row].name
		
		return cell
	}
	
	func titleForHeaderIn(_ section: Int) -> String? {
		let keysCount = shops.keys.count
		if section < keysCount  {
			return keyOfShopOffsetBy(section)
		}
		
		return nil
	}
	
	func didLoad() {
		shopsInit()
		
		view?.reloadShopsTable()
	}
	
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
