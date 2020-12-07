//
//  ShopDetailViewController.swift
//  Shop
//
//  Created by Nikulux on 30.11.2020.
//

import UIKit

class ShopDetailViewController: UIViewController, ShopDetailViewModelOutput {
	
	@IBOutlet weak var settingsTable: UITableView!
	@IBOutlet weak var saveButton: UIButton!

	private var viewModel: ShopDetailViewModel
	
	private let cellReuseIdentifier: String = "settingCell"

	
	init(container: Container) {
		viewModel = container.viewModel
		
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("Unable to use init with coder")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		settingsTable.register(UITableViewCell.self,
                               forCellReuseIdentifier: cellReuseIdentifier)
	}

	
	@IBAction func saveTap(_ sender: UIButton) {
		viewModel.saveShop { [weak self] in
            self?.viewModel.showShopList()
		}
	}
}

extension ShopDetailViewController {
	struct Container {
		let viewModel: ShopDetailViewModel
	}
}


// MARK: - TableView

extension ShopDetailViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		Shop.DetailNames.allCases.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = settingsTable.dequeueReusableCell(withIdentifier: cellReuseIdentifier,
                                                     for: indexPath)
		
		let (content, shopDetailKey) = viewModel.formatPropertyOfShopBy(indexPath.row)
		
		if let shopDetailKey = shopDetailKey {
			if shopDetailKey == .officeHours {
				cell.tag = 1
			}
		}
		
		cell.textLabel?.text = content
		
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let cell = tableView.cellForRow(at: indexPath)
		if cell?.tag == 1 {
			actionOnCellTap()
		}
	}
	
	private func actionOnCellTap() {
		viewModel.showOperatingTime()
	}
}
