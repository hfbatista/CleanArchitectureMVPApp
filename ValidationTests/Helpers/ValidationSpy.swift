//
//  ValidationSpy.swift
//  ValidationTests
//
//  Created by Henrique Batista on 26/08/21.
//

import Foundation
import Presentation

class ValidationSpy: ValidationProtocol {
	var errorMessage: String?
	var data: [String: Any]?
	
	func validate(data: [String : Any]?) -> String? {
		self.data = data
		return errorMessage
	}
	
	func simulateError(with errorMessage: String) {
		self.errorMessage = errorMessage
	}
}
