import Foundation

protocol OperatingTimeViewModelInput {
	func didLoad(completion: @escaping (_ operatingTime: OfficeHours) -> Void)
}
