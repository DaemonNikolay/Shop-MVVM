import UIKit

class ShopListViewController: UIViewController {
	
	@IBOutlet weak var tableShops: UITableView!
	
	private var viewModel: ShopListViewModelInput
	private let cellReuseIdentifier: String = "myCell"
	
	// MARK: - Initialize
	
	init (container: Container) {
		viewModel = container.viewModel
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("Unable to use init with coder")
	}
	
	// MARK: - Lifecycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		tableShops.register(UITableViewCell.self,
                            forCellReuseIdentifier: cellReuseIdentifier)
		
		viewModel.didLoad()
	}
}

// MARK: - Output

extension ShopListViewController: ShopListViewModelOutput {
	func reloadShopsTable() {
		tableShops.reloadData()
	}
}

// MARK: - DI container

extension ShopListViewController {
	struct Container {
		let viewModel: ShopListViewModel
	}
}

// MARK: - TableView

extension ShopListViewController: UITableViewDelegate, UITableViewDataSource {
	func numberOfSections(in tableView: UITableView) -> Int {
		viewModel.rowsCount()
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		viewModel.numberOfRowsIn(section)
	}

	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		viewModel.titleForHeaderIn(section)
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		viewModel.fillCellBy(indexPath, tableView: tableShops, identifier: cellReuseIdentifier)
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		viewModel.didTapCellOf(tableView, indexPath: indexPath)
	}
}
