import UIKit

class ShopDetailViewController: UIViewController {
	
	@IBOutlet weak var settingsTable: UITableView!
	@IBOutlet weak var saveButton: UIButton!

	private var viewModel: ShopDetailViewModelInput
	
	private let cellReuseIdentifier: String = "settingCell"

	// MARK: - Initialize
	
	init(container: Container) {
		viewModel = container.viewModel
		
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("Unable to use init with coder")
	}
	
	// MARK: - Lifecycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		settingsTable.register(ShopDetailCell.self,
							   forCellReuseIdentifier: cellReuseIdentifier)
		
		viewModel.didLoad()
	}
	
	// MARK: - Actions

	@IBAction func backTap(_ sender: UIButton) {
        viewModel.didBackTap()
	}
}

// MARK: - Output

extension ShopDetailViewController: ShopDetailViewModelOutput { }

// MARK: - DI container

extension ShopDetailViewController {
	struct Container {
		let viewModel: ShopDetailViewModelInput
	}
}

// MARK: - TableView

extension ShopDetailViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		viewModel.rowsCount()
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		viewModel.fillCellBy(indexPath, identifier: cellReuseIdentifier, tableView: settingsTable)
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? ShopDetailCell else {
            return
        }
        
        if cell.isOfficeHours == true {
            actionOnCellTap()
        }
	}
	
	private func actionOnCellTap() {
        viewModel.didCellTap()
	}
}
