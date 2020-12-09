import Foundation
import UIKit

// MARK: - Protocols

protocol ShopDetailViewModelInput {
	mutating func didLoad()
	func didBackTap()
	func fillCellBy(_ indexPath: IndexPath, identifier: String, tableView: UITableView) -> UITableViewCell
	func rowsCount() -> Int
	func didCellTap()
}

protocol ShopDetailViewModelOutput: class {
	func reloadSettingsTable()
}

// MARK: - ViewModel

class ShopDetailViewModel {
	private let router: ShopDetailRouter
	private weak var view: ShopDetailViewModelOutput?
	
	var currentShop: Shop?
	
	init(container: Container) {
		router = container.router
	}
	
	func setup(view: ShopDetailViewModelOutput) {
		self.view = view
	}
	
	func formatPropertyOfShopBy(_ index: Int) -> (String, Shop.DetailNames?) {
		guard let currentShop = currentShop else { return ("-", nil) }
		
		let key: Shop.DetailNames = Shop.DetailNames.allCases[index]
		var value: String
		
		switch key {
		case .employeesNumber:
			value = currentShop.employeesNumber.description
			
		case .type:
			value = currentShop.type.rawValue

		case .openingDate:
			value = currentShop.openingDate.description

		case .name:
			value = currentShop.name

		case .officeHours:
			value = "\(currentShop.officeHours.opening):\(currentShop.officeHours.closing)"
		}
		
		return ("\(key.rawValue): \(value)", key)
	}
	
	func showOperatingTime() {
		router.showOperatingTime()
	}
	
	func showShopList() {
		router.showShopList()
	}
	
	func updateShop(shopDetailType: Shop.DetailNames, value: String, completion: @escaping () -> Void) {
		switch shopDetailType {
		case .name:
			updateNameOfShop(value)

		case .employeesNumber:
			guard let employees = UInt(value) else { return }
			updateEmployeesNumberOfShop(employees)

		case .type:
			guard let type = ShopType(rawValue: value) else { return }
			updateTypeOfShop(type)

		default:
			break
		}
		
		completion()
	}
	
	func updateNameOfShop(_ name: String) {
		currentShop?.name = name
	}
	
	func updateEmployeesNumberOfShop(_ number: UInt) {
		currentShop?.employeesNumber = number
	}
	
	func updateTypeOfShop(_ type: ShopType) {
		currentShop?.type = type
	}
	
	private func extractShop(completion: @escaping () -> Void) {
		self.currentShop = DataSource.shared.currentShop
		completion()
	}
}

// MARK: - Input

extension ShopDetailViewModel: ShopDetailViewModelInput {
	func rowsCount() -> Int {
		guard let _ = currentShop else {
			return 0
		}
		
		return Shop.DetailNames.allCases.count
	}
	
	func didLoad() {
		extractShop { [weak self] in
			self?.view?.reloadSettingsTable()
		}
	}
	
	func fillCellBy(_ indexPath: IndexPath,
					identifier: String,
					tableView: UITableView) -> UITableViewCell {
		
		guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier,
													   for: indexPath) as? ShopDetailCell else {
			return UITableViewCell()
		}
		
		let (content, shopDetailKey) = formatPropertyOfShopBy(indexPath.row)
		if let shopDetailKey = shopDetailKey, shopDetailKey == .officeHours {
			cell.isOfficeHours = true
		}
		
		cell.textLabel?.text = content
		
		return cell
	}
	
    func didBackTap() {
        showShopList()
    }
    
    func didCellTap() {
        showOperatingTime()
    }
}

// MARK: - DI container

extension ShopDetailViewModel {
	struct Container {
		let router: ShopDetailRouter
	}
}
