//
//  AlertViewSpy.swift
//  PresentationTests
//
//  Created by Henrique Batista on 12/06/21.
//

import Foundation
import Presentation

class AlertViewSpy: AlertView {
	var emit: ((AlertViewModel) -> Void)?
	
	func observe(completion: @escaping (AlertViewModel) -> Void) {
		self.emit = completion
	}
	
	func showMessage(viewModel: AlertViewModel) {
		self.emit?(viewModel)
	}
}
