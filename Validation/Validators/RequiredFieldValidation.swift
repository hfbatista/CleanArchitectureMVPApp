//
//  RequiredFieldValidation.swift
//  Validation
//
//  Created by Henrique Batista on 13/08/21.
//

import Foundation
import Presentation

public final class RequiredFieldValidation: ValidationProtocol {
	private let fieldName: String
	private let fieldLabel: String
	
	public init(fieldName: String, fieldLabel: String) {
		self.fieldName = fieldName
		self.fieldLabel = fieldLabel
	}
	
	public func validate(data: [String : Any]?) -> String? {
		guard let fieldName = data?[fieldName] as? String, !fieldName.isEmpty else {
			return "O campo \(self.fieldLabel) é obrigatório!" }
		
		return nil
	}
}

extension RequiredFieldValidation: Equatable {
	public static func == (lhs: RequiredFieldValidation, rhs: RequiredFieldValidation) -> Bool {
		return lhs.fieldName == rhs.fieldName && lhs.fieldLabel == rhs.fieldLabel
	}
}
