//
//  LoadingViewSpy.swift
//  PresentationTests
//
//  Created by Henrique Batista on 12/06/21.
//

import Foundation
import Presentation

class LoadingViewSpy: LoadingView {
	var emit: ((LoadingViewModel) -> Void)?
	
	func observe(completion: @escaping (LoadingViewModel) -> Void) {
		self.emit = completion
	}
	
	func display(viewModel: LoadingViewModel) {
		self.emit?(viewModel)
	}
}
