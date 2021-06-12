//
//  WeakVarProxy.swift
//  Main
//
//  Created by Henrique Batista on 12/06/21.
//

import Foundation
import Presentation

class WeakVarProxy<T: AnyObject> {
	private weak var instance: T?
	
	init(_ instance: T) {
		self.instance = instance
	}
}

extension WeakVarProxy: AlertView where T: AlertView {
	func showMessage(viewModel: AlertViewModel) {
		instance?.showMessage(viewModel: viewModel)
	}
}

extension WeakVarProxy: LoadingView where T: LoadingView {
	func display(viewModel: LoadingViewModel) {
		instance?.display(viewModel: viewModel)
	}
}
