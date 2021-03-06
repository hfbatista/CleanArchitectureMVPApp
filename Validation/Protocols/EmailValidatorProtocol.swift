//
//  EmailValidator.swift
//  Presentation
//
//  Created by Henrique Batista on 20/05/21.
//

import Foundation

public protocol EmailValidatorProtocol {
	func isValid(email: String) -> Bool
}
