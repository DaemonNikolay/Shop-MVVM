//
//  Transition.swift
//  Shop
//
//  Created by Nikulux on 02.12.2020.
//

import UIKit

protocol Transition: class {
	var viewController: UIViewController? { get set }
	
	func open(_ viewController: UIViewController)
	func close(_ viewController: UIViewController)
}


