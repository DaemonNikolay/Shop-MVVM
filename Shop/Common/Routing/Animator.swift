//
//  Animator.swift
//  Shop
//
//  Created by Nikulux on 02.12.2020.
//

import UIKit

protocol Animator: UIViewControllerAnimatedTransitioning {
	var isPresenting: Bool { get set }
}

