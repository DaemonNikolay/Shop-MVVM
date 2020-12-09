import Foundation
import UIKit

// MARK: - Protocols

protocol OperatingTimeViewModelOutput: class {
	func reloadTime()
}

protocol OperatingTimeViewModelInput: class {
    func didLoad()
	func extractDateFrom(_ time: Float?) -> Date?
	func extractDateFromOpeningTime() -> Date?
	func extractDateFromClosingTime() -> Date?
	
	func didChangeOpeningTime(_ sender: UIDatePicker)
	func didChangeClosingTime(_ sender: UIDatePicker)
	func didSaveTap()
	func backTap()
}

// MARK: - ViewModel

class OperatingTimeViewModel {
	private let router: OperatingTimeRouter
	private weak var view: OperatingTimeViewModelOutput?
	
	var currentShopOperatingTime: OfficeHours?
	var currentShop: Shop?
	let dataSource: DataSource = DataSource.shared
	
	// MARK: - Initialize
	
	init(container: Container) {
		router = container.router
	}
	
	func setup(view: OperatingTimeViewModelOutput) {
		self.view = view
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
	
	private func extractCurrentShop(comletion: @escaping () -> Void) {
		currentShop = dataSource.currentShop
		configureOfficeHours()
		
		comletion()
	}
	
	private func configureOfficeHours() {
		if let officeHours = currentShop?.officeHours {
			currentShopOperatingTime = officeHours
		} else {
			currentShopOperatingTime = OfficeHours()
		}
	}
	
	private func formatDateOf(_ timeHours: Float?) -> Date? {
		guard let time = timeHours, let formatTime = extractDateFrom(time) else {
			return nil
		}
		
		return formatTime
	}
}

// MARK: - Input

extension OperatingTimeViewModel: OperatingTimeViewModelInput {
	func extractDateFromOpeningTime() -> Date? {
		formatDateOf(self.currentShopOperatingTime?.opening)
	}
	
	func extractDateFromClosingTime() -> Date? {
		formatDateOf(self.currentShopOperatingTime?.closing)
	}
	
	func backTap() {
		showShopList()
	}
	
	func didSaveTap() {
		updateCurrentShop()
	}
	
	func didChangeClosingTime(_ sender: UIDatePicker) {
		updateClosingTimeOf(sender.date)
	}
	
	func didChangeOpeningTime(_ sender: UIDatePicker) {
		updateOpeningTimeOf(sender.date)
	}
	
	func extractDateFrom(_ time: Float?) -> Date? {
		guard let time = time else {
			return nil
		}
		
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = Constant.DateFormat.RU.rawValue

		guard let date = dateFormatter.date(from: time.description) else { return Date() }
		
		return date
	}
	
    func didLoad() {
		extractCurrentShop { [weak self] in
			self?.view?.reloadTime()
		}
    }
}

// MARK: - DI container

extension OperatingTimeViewModel {
	struct Container {
		let router: OperatingTimeRouter
	}
}
