//
//  ShopListViewController.swift
//  Shop
//
//  Created by Nikulux on 30.11.2020.
//

import UIKit

class ShopListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
	
	@IBOutlet weak var tableShops: UITableView!
	
	private var viewModel: ShopListViewModel?
	private let cellReuseIdentifier: String = "myCell"
	
	
	required init (container: Container) {
		self.viewModel = container.viewModel
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.tableShops.register(UITableViewCell.self,
								 forCellReuseIdentifier: self.cellReuseIdentifier)

		self.tableShops.delegate = self
		self.tableShops.dataSource = self
		
		
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		self.viewModel?.shops.count ?? 0
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		let key: String = self.keyOfShopOffsetBy(section)
		
		return self.viewModel?.shops[key]?.count ?? 0
	}

	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		let keysCount = self.viewModel?.shops.keys.count ?? 0
		if section < keysCount  {
			return self.keyOfShopOffsetBy(section)
		}
		
		return nil
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell: UITableViewCell = self.tableShops.dequeueReusableCell(withIdentifier: self.cellReuseIdentifier, for: indexPath)
		
		let key = self.keyOfShopOffsetBy(indexPath.section)
		guard let shops = self.viewModel?.shops[key] else {
			cell.textLabel?.text = "-"
			
			return cell
		}
		
		cell.textLabel?.text = shops[indexPath.row].name
		
		return cell
	}
	
	private func keyOfShopOffsetBy(_ offsetBy: Int) -> String {
		guard var viewModel = self.viewModel else {
			return "-"
		}
		
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
