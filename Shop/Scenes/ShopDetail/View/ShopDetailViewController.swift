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
									   completion: { type, title, propertyValue in
										
										self.actionOnCellTap(type: type,
															 title: title,
															 propertyValue: propertyValue)
		})
	}
	
	private func actionOnCellTap(type: ActionType, title: String?, propertyValue: String?) {
		switch type {
		case .popupText:
			self.showDialogPopupOfText(title: title ?? "-",
									   currentValue: propertyValue ?? "-")
			
		case .popupShopType:
			self.showDialogPopupOfShopType(title: title ?? "-",
										   currentValue: propertyValue ?? "-")
		
		case .showOperatingTime:
			self.viewModel.showOperatingTime()
		}
	}
	
	private func showDialogPopupOfText(title: String, currentValue: String) {
		let alert = UIAlertController(title: title, message: "Current: \(currentValue)", preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

		alert.addTextField(configurationHandler: { textField in
			textField.placeholder = "Enter..."
		})

		alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
			if let value = alert.textFields?.first?.text {
				print(value)
			}
		}))

		self.present(alert, animated: true)
	}
	
	private func showDialogPopupOfShopType(title: String, currentValue: String) {
		let alert = UIAlertController(title: title, message: "Current: \(currentValue)", preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

		alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
			if let value = alert.textFields?.first?.text {
				print(value)
			}
		}))

		self.present(alert, animated: true)
	}
	
	
	@IBAction func saveClick(_ sender: UIButton) {
		self.viewModel.showShopList()
	}
}

extension ShopDetailViewController {
	struct Container {
		let viewModel: ShopDetailViewModel
	}
}

enum ActionType {
	case popupShopType
	case popupText
	case showOperatingTime
}
