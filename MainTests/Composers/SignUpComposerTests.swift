//
//  SignUpComposerTests.swift
//  SignUpComposerTests
//
//  Created by Henrique Batista on 12/06/21.
//

import XCTest
import Main
import UI

class SignUpComposerTests: XCTestCase {
	func test_background_request_should_complete_on_main_thread() throws {
		let (sut, _) = makeSUT()
		sut.loadViewIfNeeded()
	}
}

extension SignUpComposerTests {
	func makeSUT() -> (sut: SignUpViewController, createAccountSpy: CreateAccountSpy) {
		let createAccountSpy = CreateAccountSpy()
		let sut = SignUpComposer.composeViewControllerWith(createAccount: createAccountSpy)
		checkMemoryLeak(for: createAccountSpy)
		checkMemoryLeak(for: sut)
		
		return (sut, createAccountSpy)
	}
}
