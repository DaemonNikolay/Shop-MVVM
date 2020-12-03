//
//  ShopDetailViewController.swift
//  Shop
//
//  Created by Nikulux on 30.11.2020.
//

import UIKit

class ShopDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		UITableViewCell()
	}
	
	
	@IBOutlet weak var shopSettings: UITableView!
	
	@IBOutlet weak var editButton: UIButton!
	@IBAction func editClick(_ sender: UIButton) {
	}
	
	@IBOutlet weak var saveButton: UIButton!
	@IBAction func saveClick(_ sender: UIButton) {
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.setupTable()
	}
	
	private func setupTable() {
		self.shopSettings.delegate = self
		self.shopSettings.dataSource = self
	}
	
	
}

extension ShopDetailViewController {
	struct Container {
		let viewModel: ShopDetailViewModel
	}
}
