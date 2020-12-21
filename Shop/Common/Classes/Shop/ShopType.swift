import Foundation

enum ShopType: String, CaseIterable, Codable {
	private enum CodingKeys: String, CodingKey {
		case department
		case grocery
		case electrical
		case clothing
	}
	
	case department = "Department"
	case grocery = "Grocery"
	case electrical = "Electrical"
	case clothing = "Clothing"
}
