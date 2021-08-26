//
//  ValidationSpy.swift
//  PresentationTests
//
//  Created by Henrique Batista on 13/08/21.
//

import Foundation
import Presentation

class ValidationSpy: ValidationProtocol {
	var data: [String: Any]?
	var errorMessage: String?
	
	func validate(data: [String : Any]?) -> String? {
		self.data = data
		return errorMessage
	}
	
	func simulateError() {
		self.errorMessage = "Erro"
	}
}
