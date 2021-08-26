//
//  RequiredFieldValidationTests.swift
//  ValidationTests
//
//  Created by Henrique Batista on 13/08/21.
//

import XCTest
import Presentation
import Validation

class CompareFieldValidationTests: XCTestCase {
	func test_validate_should_return_error_if_comparation_fails() {
		let sut = makeSUT(fieldName: "password", fieldLabel: "Senha", fieldNameToCompare: "passwordConfirmation")
		let errorMessage = sut.validate(data: ["password": "123", "passwordConfirmation": "1234"])
		XCTAssertEqual(errorMessage, "O campo Senha é inválido!")
	}
	
	func test_validate_should_return_error_with_correct_fieldLabel() {
		let sut = makeSUT(fieldName: "password", fieldLabel: "Confirmar senha", fieldNameToCompare: "passwordConfirmation")
		let errorMessage = sut.validate(data: ["password": "123", "passwordConfirmation": "1234"])
		XCTAssertEqual(errorMessage, "O campo Confirmar senha é inválido!")
	}
	
	func test_validate_should_return_nil_if_comparation_Succeeds() {
		let sut = makeSUT(fieldName: "password", fieldLabel: "Senha", fieldNameToCompare: "password")
		let errorMessage = sut.validate(data: ["password": "123", "passwordConfirmation": "123"])
		XCTAssertNil(errorMessage)
	}
	
	func test_validate_should_return_nil_if_no_data_is_providaded() {
		let sut = makeSUT(fieldName: "password", fieldLabel: "Senha", fieldNameToCompare: "password")
		let errorMessage = sut.validate(data: nil)
		XCTAssertEqual(errorMessage, "O campo Senha é inválido!")
	}
}

extension CompareFieldValidationTests {
	func makeSUT(fieldName: String, fieldLabel: String, fieldNameToCompare: String, file: StaticString = #filePath, line: UInt = #line) -> ValidationProtocol {
		let sut = CompareFieldsValidation(fieldName: fieldName, fieldLabel: fieldLabel, fieldNameToCompare: fieldNameToCompare)
		checkMemoryLeak(for: sut, file: file, line: line)
		
		return sut
	}
}
