//
//  OperatingTimeViewController.swift
//  Shop
//
//  Created by Nikulux on 30.11.2020.
//

import UIKit

class OperatingTimeViewController: UIViewController, OperatingTimeViewModelOutput {
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
		
		self.setupOperatingTime()
	}
	
	private func setupOperatingTime() {
		guard let operatingTime = self.viewModel.currentShopOperatingTime else { return }
		
		self.openingTime.date = self.extractDateFrom(operatingTime.opening)
		self.closingTime.date = self.extractDateFrom(operatingTime.closing)
	}
	
	private func extractDateFrom(_ time: Float) -> Date {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "HH.mm"

		guard let date = dateFormatter.date(from: time.description) else { return Date() }
		
		return date
	}
	
	@IBAction func openingTimeChanged(_ sender: UIDatePicker) {
		self.viewModel.updateOpeningTimeOf(sender.date)
	}
	
	@IBAction func closingTimeChanged(_ sender: UIDatePicker) {
		self.viewModel.updateClosingTimeOf(sender.date)
	}
	
	@IBAction func saveTap(_ sender: UIButton) {
		self.viewModel.updateCurrentShop()
	}
}

extension OperatingTimeViewController {
	struct Container {
		let viewModel: OperatingTimeViewModel
	}
}
