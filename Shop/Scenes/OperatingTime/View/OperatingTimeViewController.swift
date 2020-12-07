import UIKit

class OperatingTimeViewController: UIViewController {
    
	@IBOutlet weak var openingTime: UIDatePicker!
	@IBOutlet weak var closingTime: UIDatePicker!
	
	private var viewModel: OperatingTimeViewModel
	
	init (container: Container) {
		viewModel = container.viewModel
		
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupOutput()
	}
	
	private func setupOutput() {
		viewModel.didLoad(completion: { [weak self] (operatingTime) in
			self?.setupOperatingTime(operatingTime)
		})
	}
	
	private func setupOperatingTime(_ operatingTime: OfficeHours) {
		openingTime.date = extractDateFrom(operatingTime.opening)
		closingTime.date = extractDateFrom(operatingTime.closing)
	}
	
	private func extractDateFrom(_ time: Float) -> Date {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "HH.mm"

		guard let date = dateFormatter.date(from: time.description) else { return Date() }
		
		return date
	}
	
	@IBAction func openingTimeChanged(_ sender: UIDatePicker) {
		viewModel.updateOpeningTimeOf(sender.date)
	}
	
	@IBAction func closingTimeChanged(_ sender: UIDatePicker) {
		viewModel.updateClosingTimeOf(sender.date)
	}
	
	@IBAction func saveTap(_ sender: UIButton) {
		viewModel.updateCurrentShop()
	}
    @IBAction func backTap(_ sender: Any) {
        viewModel.showShopList()
    }
}

// MARK: - DI container

extension OperatingTimeViewController {
	struct Container {
		let viewModel: OperatingTimeViewModel
	}
}

extension OperatingTimeViewController: OperatingTimeViewModelOutput { }
