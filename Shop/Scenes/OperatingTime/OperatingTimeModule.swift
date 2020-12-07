import UIKit

struct OperatingTimeModule {
	let view: UIViewController
	
	init(transition: Transition) {
		let router = OperatingTimeRouter()
		
		let viewModel = OperatingTimeViewModel(container: .init(router: router))
		let view = OperatingTimeViewController(container: .init(viewModel: viewModel))
		
		router.viewController = view
		router.openTransition = transition
		
		self.view = view
	}
}
