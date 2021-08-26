//
//  VslidationCompositeTests.swift
//  ValidationTests
//
//  Created by Henrique Batista on 26/08/21.
//

import XCTest
import Presentation
import Validation

class VslidationCompositeTests: XCTestCase {
	func test_validate_should_return_error_if_validation_fails() {
		let validationSpy = ValidationSpy()
		validationSpy.simulateError(with: "Erro 1")
		let sut = makeSUT(validations: [validationSpy])
		let errorMessage = sut.validate(data: ["name": "Henrique"])
		
		XCTAssertEqual(errorMessage, "Erro 1")
	}
	
	func test_validate_should_return_correct_error_message() {
		let validationsSpy = getValidationsSpy(amount: 2)
		validationsSpy[1].simulateError(with: "Erro 3")
		let sut = makeSUT(validations: validationsSpy)
		let errorMessage = sut.validate(data: ["name": "Henrique"])
		
		XCTAssertEqual(errorMessage, "Erro 3")
	}
	
	func test_validate_should_return_the_first_error_message() {
		let validationsSpy = getValidationsSpy(amount: 3)
		validationsSpy[1].simulateError(with: "Erro 2")
		validationsSpy[2].simulateError(with: "Erro 3")
		let sut = makeSUT(validations: validationsSpy)
		let errorMessage = sut.validate(data: ["name": "Henrique"])
		
		XCTAssertEqual(errorMessage, "Erro 2")
	}
	
	func test_validate_should_return_nil_if_validation_succeeds() {
		let sut = makeSUT(validations: [ValidationSpy(), ValidationSpy()])
		let errorMessage = sut.validate(data: ["name": "Henrique"])
		
		XCTAssertNil(errorMessage)
	}
	
	func test_validate_should_call_validation_with_correct_data() {
		let validationSpy = ValidationSpy()
		let data = ["name": "Henrique"]
		let sut = makeSUT(validations: [validationSpy])
		_ = sut.validate(data: data)
		
		XCTAssertTrue(NSDictionary(dictionary: validationSpy.data!).isEqual(to: data))
	}
}

extension VslidationCompositeTests {
	func makeSUT(validations: [ValidationProtocol], file: StaticString = #filePath, line: UInt = #line) -> ValidationComposite {
		let sut = ValidationComposite(validations: validations)
		
		checkMemoryLeak(for: sut, file: file, line: line)
		return sut
	}
	
	func getValidationsSpy(amount: Int = 1) -> [ValidationSpy] {
		var validationsSpy: [ValidationSpy] = []
		if amount < 1 { return [ValidationSpy()] }
		
		for _ in 0...amount {
			validationsSpy.append(ValidationSpy())
		}
		
		return validationsSpy
	}
}
