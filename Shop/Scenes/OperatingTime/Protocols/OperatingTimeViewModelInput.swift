//
//  OperatingTimeViewModelInput.swift
//  Shop
//
//  Created by Nikulux on 04.12.2020.
//

import Foundation

protocol OperatingTimeViewModelInput {
	func didLoad(completion: @escaping (_ operatingTime: OfficeHours) -> Void)
}
