//
//  ValidationTests.swift
//  ValidationTests
//
//  Created by Henrique Batista on 12/06/21.
//

import XCTest
import Presentation

public final class EmailValidatorAdapter: EmailValidator {
	private let pattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
	
	public func isValid(email: String) -> Bool {
		let range = NSRange(location: 0, length: email.utf16.count)
		let regex = try! NSRegularExpression(pattern: pattern)
		return regex.firstMatch(in: email, options: [], range: range) != nil
	}
}

class EmailValidationAdapterTests: XCTestCase {

    func test_invalid_emails() throws {
		let sut = EmailValidatorAdapter()
		XCTAssertFalse(sut.isValid(email: "eer"))
		XCTAssertFalse(sut.isValid(email: "ree@"))
		XCTAssertFalse(sut.isValid(email: "rer@ree"))
		XCTAssertFalse(sut.isValid(email: "reE@rer."))
		XCTAssertFalse(sut.isValid(email: "@dfg.com"))
	}
}
