import Foundation

class DataSource {
	private let keyShopIds: String = "shops"
	
	static var shared: DataSource = {
		DataSource()
	}()
	
	private let dataSource: UserDefaults
	
	private init() {
		dataSource = UserDefaults.standard
	}
	
	var currentShop: Shop?
	
	var shopCount: Int {
		get {
			let shopIds = getShopIds()
			
			return shopIds?.count ?? 0
		}
	}
	
	func addShop(shop: Shop) {
		try? dataSource.setObject(shop, forKey: shop.id.description)
		updateShopIds(id: shop.id.description)
	}
	
	func shops() -> Array<Shop>? {
		guard let shopIds: Array<String> = getShopIds() else { return nil }
        
        var shops: Array<Shop> = []
        shopIds.forEach { shopId in
            if let shop = shop(id: shopId) {
                shops.append(shop)
            }
        }
			
		return shops
	}
	
	func shop(id: String) -> Shop? {
		guard let shop = try? dataSource.getObject(forKey: id, castTo: Shop.self) else { return nil }
		
		return shop
	}
	
	func updateShop(shop: Shop) {
        guard let _ = self.shop(id: shop.id.description) else { return }
		
		try? dataSource.setObject(shop, forKey: shop.id.description)
	}
	
	private func getShopIds() -> Array<String>? {
		let userDefaults = UserDefaults.standard
		let shopIds = userDefaults.array(forKey: keyShopIds) as? Array<String>
		
		return shopIds
	}
	
	private func updateShopIds(id: String) {
		guard var shopIds = getShopIds() else {
			let shopIds = [id]
			dataSource.setValue(shopIds, forKey: keyShopIds)
			
			return
		}
		
		shopIds.append(id)
		dataSource.setValue(shopIds, forKey: keyShopIds)
	}
}
