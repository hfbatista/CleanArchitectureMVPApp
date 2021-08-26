//
//  ValidationComposite.swift
//  Validation
//
//  Created by Henrique Batista on 26/08/21.
//

import Foundation
import Presentation

public final class ValidationComposite: ValidationProtocol {
	private let validations: [ValidationProtocol]
	
	public init(validations: [ValidationProtocol]) {
		self.validations = validations
	}
	
	public func validate(data: [String : Any]?) -> String? {
		for validation in validations {
			if let errorMessage = validation.validate(data: data) {
				return errorMessage
			}
		}
		
		return nil
	}
}
