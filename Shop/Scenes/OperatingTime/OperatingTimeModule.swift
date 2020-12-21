import UIKit

struct OperatingTimeModule {
	let view: UIViewController
	
	init(transition: Transition) {
		let router = OperatingTimeRouter()
		
		let viewModel = OperatingTimeViewModel(container: .init(router: router))
		let view = OperatingTimeViewController(container: .init(viewModel: viewModel))
		viewModel.setup(view: view)
		
		router.viewController = view
		router.openTransition = transition
		
		self.view = view
	}
}
