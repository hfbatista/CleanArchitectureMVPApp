//
//  RequiredFieldValidation.swift
//  Validation
//
//  Created by Henrique Batista on 13/08/21.
//

import Foundation
import Presentation

public final class CompareFieldsValidation: ValidationProtocol {
	private let fieldName: String
	private let fieldLabel: String
	private let fieldNameToCompare: String
	
	public init(fieldName: String, fieldLabel: String, fieldNameToCompare: String) {
		self.fieldName = fieldName
		self.fieldLabel = fieldLabel
		self.fieldNameToCompare = fieldNameToCompare
	}
	
	public func validate(data: [String : Any]?) -> String? {
		guard let fieldName = data?[fieldName] as? String,
			  let fieldNameToCompare = data?[fieldNameToCompare] as? String,
				  fieldName == fieldNameToCompare else { return "O campo \(self.fieldLabel) é inválido!" }
		
		return nil
	}
}

extension CompareFieldsValidation: Equatable {
	public static func == (lhs: CompareFieldsValidation, rhs: CompareFieldsValidation) -> Bool {
		return lhs.fieldName == rhs.fieldName &&
			   lhs.fieldLabel == rhs.fieldLabel &&
			   lhs.fieldNameToCompare == rhs.fieldNameToCompare
	}
}
