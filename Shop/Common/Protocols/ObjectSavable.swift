//
//  ObjectSaveble.swift
//  Shop
//
//  Created by Nikulux on 01.12.2020.
//

import Foundation

protocol ObjectSavable {
	func setObject<Object>(_ object: Object, forKey: String) throws where Object: Encodable
	func getObject<Object>(forKey: String, castTo type: Object.Type) throws -> Object where Object: Decodable
}
