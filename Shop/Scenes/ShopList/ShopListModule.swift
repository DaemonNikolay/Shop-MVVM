import Foundation
import UIKit

struct ShopListModule {
	let view: UIViewController
	
	init(transition: Transition) {
		let router = ShopListRouter()
		
		let viewModel = ShopListViewModel(container: .init(router: router))
		let view = ShopListViewController(container: .init(viewModel: viewModel))
		
		router.viewController = view
		router.openTransition = transition
		
		self.view = view
	}
}
