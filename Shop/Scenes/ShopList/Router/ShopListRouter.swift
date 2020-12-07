import Foundation

final class ShopListRouter: Router<ShopListViewController>, ShopListRouter.Routes {
	typealias Routes = ShopDetailRoute & OperatingTimeRoute
}
