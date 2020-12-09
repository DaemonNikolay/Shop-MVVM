import UIKit

class OperatingTimeViewController: UIViewController {
    
	@IBOutlet weak var openingTime: UIDatePicker!
	@IBOutlet weak var closingTime: UIDatePicker!
	
	private var viewModel: OperatingTimeViewModelInput
	
	// MARK: - Initialize
	
	init (container: Container) {
		viewModel = container.viewModel
		
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Lifecycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		viewModel.didLoad()
	}
	
	private func setupOperatingTime() {
		openingTime.date = viewModel.extractDateFromOpeningTime() ?? Date()
		closingTime.date = viewModel.extractDateFromClosingTime() ?? Date()
	}
	
	// MARK: - Actions
	
	@IBAction func openingTimeChanged(_ sender: UIDatePicker) {
		viewModel.didChangeOpeningTime(sender)
	}
	
	@IBAction func closingTimeChanged(_ sender: UIDatePicker) {
		viewModel.didChangeClosingTime(sender)
	}
	
	@IBAction func saveTap(_ sender: UIButton) {
		viewModel.didSaveTap()
	}
	
    @IBAction func backTap(_ sender: UIButton) {
        viewModel.backTap()
    }
}

// MARK: - Output

extension OperatingTimeViewController: OperatingTimeViewModelOutput {
	func reloadTime() {
		self.setupOperatingTime()
	}
}

// MARK: - DI container

extension OperatingTimeViewController {
	struct Container {
		let viewModel: OperatingTimeViewModel
	}
}
