import Foundation

final class ShopDetailRouter: Router<ShopDetailViewController>, ShopDetailRouter.Routes {
	typealias Routes = OperatingTimeRoute & ShopListRoute
}
