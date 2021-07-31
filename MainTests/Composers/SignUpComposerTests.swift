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
		let (sut, createAccountSpy) = makeSUT()
		sut.loadViewIfNeeded()
		sut.signUp?(makeSignUpViewModel())
		let exp = expectation(description: "waiting")
		
		DispatchQueue.global().async {
			createAccountSpy.completeWithError(.unexpected)
			exp.fulfill()
		}
		wait(for: [exp], timeout: 2)
	}
}

extension SignUpComposerTests {
	func makeSUT(file: StaticString = #filePath, line: UInt = #line) -> (sut: SignUpViewController, createAccountSpy: CreateAccountSpy) {
		let createAccountSpy = CreateAccountSpy()
		let sut = SignUpComposer.composeViewControllerWith(createAccount: MainDispatchQueueDecorator(createAccountSpy))
		checkMemoryLeak(for: createAccountSpy, file: file, line: line)
		checkMemoryLeak(for: sut, file: file, line: line)
		
		return (sut, createAccountSpy)
	}
}
