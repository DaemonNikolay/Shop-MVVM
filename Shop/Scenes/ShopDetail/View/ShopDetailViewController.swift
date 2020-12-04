//
//  ShopDetailViewController.swift
//  Shop
//
//  Created by Nikulux on 30.11.2020.
//

import UIKit

class ShopDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
	
	@IBOutlet weak var settingsTable: UITableView!
	@IBOutlet weak var saveButton: UIButton!

	private var viewModel: ShopDetailViewModel
	
	private let cellReuseIdentifier: String = "settingCell"

	
	init(container: Container) {
		self.viewModel = container.viewModel
		
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("Unable to use init with coder")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.settingsTable.register(UITableViewCell.self,
									forCellReuseIdentifier: self.cellReuseIdentifier)
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		Shop.DetailNames.allCases.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = self.settingsTable.dequeueReusableCell(withIdentifier: self.cellReuseIdentifier,
														  for: indexPath)
		
		cell.textLabel?.text = self.viewModel.formatPropertyOfShopBy(indexPath.row)
		
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		self.viewModel.actionOnCellTap(numberRow: indexPath.row,
									   completion: { type in
										
										self.actionOnCellTap(type: type)
		})
	}
	
	private func actionOnCellTap(type: ActionType) {
		
		switch type {
		case .showOperatingTime:
			self.viewModel.showOperatingTime()
		}
	}
	
	@IBAction func saveTap(_ sender: UIButton) {
		self.viewModel.saveShop {
			self.viewModel.showShopList()
		}
	}
}

extension ShopDetailViewController {
	struct Container {
		let viewModel: ShopDetailViewModel
	}
}

enum ActionType {
	case showOperatingTime
}
