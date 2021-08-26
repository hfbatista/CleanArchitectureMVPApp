//
//  EmailValidationTests.swift
//  ValidationTests
//
//  Created by Henrique Batista on 25/08/21.
//

import XCTest
import Validation

class EmailValidationTests: XCTestCase {
	func test_validate_should_return_error_if_invalid_email_is_provided() {
		let emailValidatorSpy = EmailValidatorSpy()
		emailValidatorSpy.simulateInvalidEmail()
		let sut = makeSUT(emailValidatorSpy: emailValidatorSpy)
		let errorMessage = sut.validate(data: ["email": "invalid_email@gmail.com"])
		
		XCTAssertEqual(errorMessage, "O campo Email é inválido")
	}
	
	func test_validate_should_return_error_with_correct_fieldLabel() {
		let emailValidatorSpy = EmailValidatorSpy()
		emailValidatorSpy.simulateInvalidEmail()
		let sut = makeSUT(emailValidatorSpy: emailValidatorSpy)
		let errorMessage = sut.validate(data: ["email": "invalid_email@gmail.com"])
		
		XCTAssertEqual(errorMessage, "O campo Email é inválido")
	}
	
	func test_validate_should_return_nil_if_valid_email_is_provided() {
		let sut = makeSUT(emailValidatorSpy: EmailValidatorSpy())
		let errorMessage = sut.validate(data: ["email": "invalid_email@gmail.com"])
		
		XCTAssertNil(errorMessage)
	}
	
	func test_validate_should_return_error_if_no_data_is_provided() {
		let sut = makeSUT(emailValidatorSpy: EmailValidatorSpy())
		let errorMessage = sut.validate(data: nil)
		
		XCTAssertEqual(errorMessage, "O campo Email é inválido")
	}
}


extension EmailValidationTests {
	func makeSUT(fieldName: String = "email", fieldLabel: String = "Email", emailValidatorSpy: EmailValidatorProtocol, file: StaticString = #filePath, line: UInt = #line) -> EmailValidation {
		let sut = EmailValidation(fieldName: fieldName,
							   fieldLabel: fieldLabel,
							   emailValidatorSpy: emailValidatorSpy)
		checkMemoryLeak(for: sut, file: file, line: line)
		return sut
	}
}
