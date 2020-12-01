//
//  ShopType.swift
//  Shop
//
//  Created by Nikulux on 30.11.2020.
//

import Foundation

enum ShopType: Int, CaseIterable, Codable {
//	func encode(to encoder: Encoder) throws {
//
//	}
//
//	init(from decoder: Decoder) throws {
//		try self.init(from: decoder)
//	}
//
	private enum CodingKeys: String, CodingKey {
		case department
		case grocery
		case electrical
		case clothing
	}
	
	case department
	case grocery
	case electrical
	case clothing
}
