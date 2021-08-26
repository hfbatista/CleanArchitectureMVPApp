//
//  RequiredFieldValidationTests.swift
//  ValidationTests
//
//  Created by Henrique Batista on 13/08/21.
//

import XCTest
import Presentation
import Validation

class RequiredFieldValidationTests: XCTestCase {
	func test_validate_should_return_error_if_field_is_not_provided() {
		let sut = makeSUT(fieldName: "email", fieldLabel: "Email")
		let errorMessage = sut.validate(data: ["name": "Rodrigo"])
		XCTAssertEqual(errorMessage, "O campo Email é obrigatório!")
	}
	
	func test_validate_should_return_error_with_correct_fieldLabel() {
		let sut = makeSUT(fieldName: "age", fieldLabel: "Idade")
		let errorMessage = sut.validate(data: ["name": "Rodrigo"])
		XCTAssertEqual(errorMessage, "O campo Idade é obrigatório!")
	}
	
	func test_validate_should_return_nil_if_field_is_providaded() {
		let sut = makeSUT(fieldName: "email", fieldLabel: "Email")
		let errorMessage = sut.validate(data: ["email": "teste@teste.com"])
		XCTAssertNil(errorMessage)
	}
	
	func test_validate_should_return_nil_if_no_data_is_providaded() {
		let sut = makeSUT(fieldName: "email", fieldLabel: "Email")
		let errorMessage = sut.validate(data: nil)
		XCTAssertEqual(errorMessage, "O campo Email é obrigatório!")
	}
}

extension RequiredFieldValidationTests {
	func makeSUT(fieldName: String, fieldLabel: String, file: StaticString = #filePath, line: UInt = #line) -> ValidationProtocol {
		let sut = RequiredFieldValidation(fieldName: fieldName, fieldLabel: fieldLabel)
		checkMemoryLeak(for: sut, file: file, line: line)
		return sut
	}
}
