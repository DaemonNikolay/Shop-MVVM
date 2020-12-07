import UIKit

class ShopListViewController: UIViewController, ShopListViewModelOutput {
	
	@IBOutlet weak var tableShops: UITableView!
	
	private var viewModel: ShopListViewModel
	private let cellReuseIdentifier: String = "myCell"
	
	
	init (container: Container) {
		viewModel = container.viewModel
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("Unable to use init with coder")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		tableShops.register(UITableViewCell.self,
                            forCellReuseIdentifier: cellReuseIdentifier)
	}
	
	private func keyOfShopOffsetBy(_ offsetBy: Int) -> String {
		let startIndex = viewModel.shops.startIndex
		let index = viewModel.shops.index(startIndex, offsetBy: offsetBy)
		let key = viewModel.shops.keys[index]
		
		return key
	}
}

extension ShopListViewController {
	struct Container {
		let viewModel: ShopListViewModel
	}
}


// MARK: - TableView

extension ShopListViewController: UITableViewDelegate, UITableViewDataSource {
	func numberOfSections(in tableView: UITableView) -> Int {
		viewModel.shops.count
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		let key: String = keyOfShopOffsetBy(section)
		
		return viewModel.shops[key]?.count ?? 0
	}

	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		let keysCount = viewModel.shops.keys.count
		if section < keysCount  {
			return keyOfShopOffsetBy(section)
		}
		
		return nil
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell: UITableViewCell = tableShops.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
		
		let key = keyOfShopOffsetBy(indexPath.section)
		guard let shops = viewModel.shops[key] else {
			cell.textLabel?.text = "-"
			
			return cell
		}
		
		cell.textLabel?.text = shops[indexPath.row].name
		
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		guard let name = tableView.cellForRow(at: indexPath)?.textLabel?.text else { return }
		
		let key = keyOfShopOffsetBy(indexPath.section)
		
		viewModel.showShopDetail(shopName: name, shopType: key)
	}
}
