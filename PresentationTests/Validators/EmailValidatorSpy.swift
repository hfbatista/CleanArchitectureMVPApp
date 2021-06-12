//
//  EmailValidatorSpy.swift
//  PresentationTests
//
//  Created by Henrique Batista on 12/06/21.
//

import Foundation
import Presentation

class EmailValidatorSpy: EmailValidator {
	var validFlag = true
	var email: String?
	
	func isValid(email: String) -> Bool{
		self.email = email
		return validFlag
	}
}
