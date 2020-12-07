import Foundation

protocol OperatingTimeViewModelOutput { }

protocol OperatingTimeViewModelInput {
    func didLoad(completion: @escaping (_ operatingTime: OfficeHours) -> Void)
}

struct OperatingTimeViewModel {
	private let router: OperatingTimeRouter
	
	var currentShopOperatingTime: OfficeHours
	var currentShop: Shop?
	let dataSource: DataSource = DataSource.shared
	
	init(container: Container) {
		router = container.router
		currentShop = dataSource.currentShop
		
		if let officeHours = currentShop?.officeHours {
			currentShopOperatingTime = officeHours
		} else {
			currentShopOperatingTime = OfficeHours()
		}
	}
	
	func updateOpeningTimeOf(_ date: Date) {
		let timeFormatString = extractFormatTimeOf(date)
		if let openingTime: Float = Float(timeFormatString) {
			currentShop?.officeHours.opening = openingTime
		}
	}
	
	func updateClosingTimeOf(_ date: Date) {
		let timeFormatString = extractFormatTimeOf(date)
		if let closingTime: Float = Float(timeFormatString) {
			currentShop?.officeHours.closing = closingTime
		}
	}
	
	func updateCurrentShop() {
		if let shop = currentShop {
			dataSource.updateShop(shop: shop)
		}
		
		showShopList()
	}
	
	func showShopList() {
        router.showShopList()
	}
	
	private func extractFormatTimeOf(_ date: Date) -> String {
		let calendar = Calendar.current
		let hour = calendar.component(.hour, from: date)
		let minutes = calendar.component(.minute, from: date)
		
		return "\(hour).\(minutes)"
	}
}

// MARK: - DI container

extension OperatingTimeViewModel {
	struct Container {
		let router: OperatingTimeRouter
	}
}

extension OperatingTimeViewModel: OperatingTimeViewModelInput {
	func didLoad(completion: @escaping (OfficeHours) -> Void) {
		completion(currentShopOperatingTime)
	}
}
