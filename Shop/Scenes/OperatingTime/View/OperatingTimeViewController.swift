//
//  OperatingTimeViewController.swift
//  Shop
//
//  Created by Nikulux on 30.11.2020.
//

import UIKit

class OperatingTimeViewController: UIViewController {
	@IBOutlet weak var openingTime: UIDatePicker!
	@IBOutlet weak var closingTime: UIDatePicker!
	
	private var viewModel: OperatingTimeViewModel
	
	init (container: Container) {
		self.viewModel = container.viewModel
		
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	@IBAction func openingTimeChanged(_ sender: UIDatePicker) {
		print(sender.date)
	}
	
	@IBAction func closingTimeChanged(_ sender: UIDatePicker) {
		print(sender.date)
	}
	
	@IBAction func saveClick(_ sender: UIButton) {
		self.viewModel.showShopList()
	}
}

extension OperatingTimeViewController {
	struct Container {
		let viewModel: OperatingTimeViewModel
	}
}
