//
//  SignUpIntegrationTests.swift
//  SignUpIntegrationTests
//
//  Created by Henrique Batista on 12/06/21.
//

import XCTest
import Main

class SignUpIntegrationTests: XCTestCase {
	func test_() throws {
		let sut = SignUpComposer.composeViewControllerWith(createAccount: CreateAccountSpy())
		checkMemoryLeak(for: sut)
	}
}
