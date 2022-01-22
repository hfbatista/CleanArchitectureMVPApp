//
//  SignUpComposerTests.swift
//  SignUpComposerTests
//
//  Created by Henrique Batista on 12/06/21.
//

import XCTest
import UI
import Main
import Validation

class SignUpFactoriesTests: XCTestCase {
	func test_background_request_should_complete_on_main_thread() throws {
		let (sut, createAccountSpy) = makeSUT()
		sut.loadViewIfNeeded()
		sut.signUp?(makeSignUpViewModel())
		let exp = expectation(description: "waiting")
		
		DispatchQueue.global().async {
			createAccountSpy.completeWithError(.unexpected)
			exp.fulfill()
		}
		wait(for: [exp], timeout: 2)
	}
	
	func test_signUp_compose_with_correct_validations() {
		let validations = makeSignupValidations()
		XCTAssertEqual(validations[0] as! RequiredFieldValidation, RequiredFieldValidation(fieldName: "name", fieldLabel: "Nome"))
		XCTAssertEqual(validations[1] as! RequiredFieldValidation, RequiredFieldValidation(fieldName: "email", fieldLabel: "Email"))
		XCTAssertEqual(validations[2] as! EmailValidation, EmailValidation(fieldName: "email", fieldLabel: "Email", emailValidatorSpy: EmailValidatorSpy()))
		XCTAssertEqual(validations[3] as! RequiredFieldValidation, RequiredFieldValidation(fieldName: "password", fieldLabel: "Senha"))
		XCTAssertEqual(validations[4] as! RequiredFieldValidation, RequiredFieldValidation(fieldName: "passwordConfirmation", fieldLabel: "Confirmar senha"))
		XCTAssertEqual(validations[5] as! CompareFieldsValidation, CompareFieldsValidation(fieldName: "password", fieldLabel: "Confirmar senha", fieldNameToCompare: "passwordConfirmation"))
		
	}
}

extension SignUpFactoriesTests {
	func makeSUT(file: StaticString = #filePath, line: UInt = #line) -> (sut: SignUpViewController, createAccountSpy: CreateAccountSpy) {
		let createAccountSpy = CreateAccountSpy()
		let sut = makeSignupViewController(createAccount: MainDispatchQueueDecorator(createAccountSpy))
		checkMemoryLeak(for: createAccountSpy, file: file, line: line)
		checkMemoryLeak(for: sut, file: file, line: line)
		
		return (sut, createAccountSpy)
	}
}
