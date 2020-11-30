//
//  ShopListViewController.swift
//  Shop
//
//  Created by Nikulux on 30.11.2020.
//

import UIKit

class ShopListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
	
	@IBOutlet weak var tableShops: UITableView!
	
	private let cellReuseIdentifier: String = "myCell"
	
	private let shops: [String:[String]] = [
		"Tech": ["Microsoft", "Apple", "Huawei"],
		"Whiskey": ["Auchentochan", "Jack Daniels"]
	]
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.tableShops.register(UITableViewCell.self,
								 forCellReuseIdentifier: self.cellReuseIdentifier)

		self.tableShops.delegate = self
		self.tableShops.dataSource = self
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		self.shops.count
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		let key: String = self.keyOfShopOffsetBy(section)
		
		return self.shops[key]?.count ?? 0
	}

	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		if section < shops.keys.count {
			return self.keyOfShopOffsetBy(section)
		}
		
		return nil
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell: UITableViewCell = self.tableShops.dequeueReusableCell(withIdentifier: self.cellReuseIdentifier, for: indexPath)
		
		let key = self.keyOfShopOffsetBy(indexPath.section)
		
		guard let shops = self.shops[key] else {
			cell.textLabel?.text = "-"
			
			return cell
		}
		
		cell.textLabel?.text = shops[indexPath.row]
		
		return cell
	}
	
	private func keyOfShopOffsetBy(_ offsetBy: Int) -> String {
		let index = self.shops.index(self.shops.startIndex, offsetBy: offsetBy)
		let key = self.shops.keys[index]
		
		return key
	}
}
