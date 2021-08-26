//
//  EmailValidation.swift
//  Validation
//
//  Created by Henrique Batista on 25/08/21.
//

import Foundation
import Presentation

public final class EmailValidation: ValidationProtocol {
	let fieldName: String
	let fieldLabel: String
	let emailValidatorSpy: EmailValidatorProtocol
	
	public init(fieldName: String, fieldLabel: String, emailValidatorSpy: EmailValidatorProtocol) {
		self.fieldName = fieldName
		self.fieldLabel = fieldLabel
		self.emailValidatorSpy = emailValidatorSpy
	}
	
	public func validate(data: [String : Any]?) -> String? {
		guard let fieldValue = data?[fieldName] as? String, emailValidatorSpy.isValid(email: fieldValue) else {
			return "O campo \(fieldLabel) é inválido"
		}
		
		return nil
	}
}

extension EmailValidation: Equatable {
	public static func == (lhs: EmailValidation, rhs: EmailValidation) -> Bool {
		return lhs.fieldName == rhs.fieldName && lhs.fieldLabel == rhs.fieldLabel
	}
}
