import UIKit

class ShopListViewController: UIViewController {
	
	@IBOutlet weak var tableShops: UITableView!
	
	private var viewModel: ShopListViewModel
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
	}
}

// MARK: - Output

extension ShopListViewController: ShopListViewModelOutput {
	func titleForHeaderIn(_ section: Int) -> String? {
		let keysCount = viewModel.shops.keys.count
		if section < keysCount  {
			return viewModel.keyOfShopOffsetBy(section)
		}
		
		return nil
	}
	
	func rowsCount() -> Int {
		viewModel.shops.count
	}
	
	func numberOfRowsIn(_ section: Int) -> Int {
		let key: String = viewModel.keyOfShopOffsetBy(section)
		
		return viewModel.shops[key]?.count ?? 0
	}
	
	func fillCellIn(_ indexPath: IndexPath) -> UITableViewCell {
		let cell: UITableViewCell = tableShops.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
		
		let key = viewModel.keyOfShopOffsetBy(indexPath.section)
		guard let shops = viewModel.shops[key] else {
			cell.textLabel?.text = "-"
			
			return cell
		}
		
		cell.textLabel?.text = shops[indexPath.row].name
		
		return cell
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
		rowsCount()
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		numberOfRowsIn(section)
	}

	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		titleForHeaderIn(section)
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		fillCellIn(indexPath)
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		viewModel.didTapCellOf(tableView, indexPath: indexPath)
	}
}
