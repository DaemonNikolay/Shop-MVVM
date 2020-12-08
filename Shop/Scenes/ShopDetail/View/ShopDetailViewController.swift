import UIKit

class ShopDetailViewController: UIViewController {
	
	@IBOutlet weak var settingsTable: UITableView!
	@IBOutlet weak var saveButton: UIButton!

	private var viewModel: ShopDetailViewModel
	
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
	}
	
	// MARK: - Actions

	@IBAction func backTap(_ sender: UIButton) {
        viewModel.didBackTap()
	}
}

// MARK: - Output

extension ShopDetailViewController: ShopDetailViewModelOutput {
    func fillCellBy(indexPath: IndexPath) -> UITableViewCell {
        guard let cell = settingsTable.dequeueReusableCell(withIdentifier: cellReuseIdentifier,
                                                           for: indexPath) as? ShopDetailCell else {
            return UITableViewCell()
        }
        
        let (content, shopDetailKey) = viewModel.formatPropertyOfShopBy(indexPath.row)
        if let shopDetailKey = shopDetailKey, shopDetailKey == .officeHours {
            cell.isOfficeHours = true
        }
        
        cell.textLabel?.text = content
        
        return cell
    }
    
    func rowsCount() -> Int {
        Shop.DetailNames.allCases.count
    }
}

// MARK: - DI container

extension ShopDetailViewController {
	struct Container {
		let viewModel: ShopDetailViewModel
	}
}

// MARK: - TableView

extension ShopDetailViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        rowsCount()
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = fillCellBy(indexPath: indexPath)
        
		return cell
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
