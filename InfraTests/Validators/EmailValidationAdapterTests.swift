//
//  ValidationTests.swift
//  ValidationTests
//
//  Created by Henrique Batista on 12/06/21.
//

import XCTest
import Infra

class EmailValidationAdapterTests: XCTestCase {

    func test_invalid_emails() throws {
		let sut = makeSut()
		XCTAssertFalse(sut.isValid(email: "eer"))
		XCTAssertFalse(sut.isValid(email: "ree@"))
		XCTAssertFalse(sut.isValid(email: "rer@ree"))
		XCTAssertFalse(sut.isValid(email: "reE@rer."))
		XCTAssertFalse(sut.isValid(email: "@dfg.com"))
	}
	
	func test_valid_emails() throws {
		let sut = makeSut()
		XCTAssertTrue(sut.isValid(email: "hfbatista@gmail.com"))
		XCTAssertTrue(sut.isValid(email: "a@b.com"))
		XCTAssertTrue(sut.isValid(email: "hfbatista@hotmail.com"))
	}
}

extension EmailValidationAdapterTests {
	func makeSut() -> EmailValidatorAdapter {
		return EmailValidatorAdapter()
	}
}
