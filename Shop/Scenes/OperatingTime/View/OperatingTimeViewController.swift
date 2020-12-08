import UIKit

class OperatingTimeViewController: UIViewController {
    
	@IBOutlet weak var openingTime: UIDatePicker!
	@IBOutlet weak var closingTime: UIDatePicker!
	
	private var viewModel: OperatingTimeViewModel
	
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
		
		setupController()
	}
	
	private func setupController() {
		viewModel.didLoad(completion: { [weak self] (operatingTime) in
			self?.setupOperatingTime(operatingTime)
		})
	}
	
	private func setupOperatingTime(_ operatingTime: OfficeHours) {
		openingTime.date = viewModel.extractDateFrom(operatingTime.opening)
		closingTime.date = viewModel.extractDateFrom(operatingTime.closing)
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

extension OperatingTimeViewController: OperatingTimeViewModelOutput { }

// MARK: - DI container

extension OperatingTimeViewController {
	struct Container {
		let viewModel: OperatingTimeViewModel
	}
}
