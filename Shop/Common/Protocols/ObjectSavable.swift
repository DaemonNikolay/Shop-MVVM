import Foundation

/// https://medium.com/flawless-app-stories/save-custom-objects-into-userdefaults-using-codable-in-swift-5-1-protocol-oriented-approach-ae36175180d8
protocol ObjectSavable {
	func setObject<Object>(_ object: Object, forKey: String) throws where Object: Encodable
	func getObject<Object>(forKey: String, castTo type: Object.Type) throws -> Object where Object: Decodable
}
