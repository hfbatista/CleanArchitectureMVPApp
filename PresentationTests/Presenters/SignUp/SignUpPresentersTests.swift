//
//  PresentationTests.swift
//  PresentationTests
//
//  Created by Henrique Batista on 20/05/21.
//

import XCTest
import Presentation
import Domain

class SignUpPresentersTests: XCTestCase {
	
	func test_signUp_should_call_add_account_with_correct_values() throws {
		let createAccountSpy = CreateAccountSpy()
		let sut = makeSUT(createAccount: createAccountSpy)
		sut.signUp(viewModel: makeSignUpViewModel())
		
		XCTAssertEqual(createAccountSpy.createAccountModel, makeCreateAccountModel())
	}
	
	func test_signUp_should_show_generic_error_message_if_createAccount_fails() throws {
		let alertViewSpy = AlertViewSpy()
		let createAccountSpy = CreateAccountSpy()
		let sut = makeSUT(alertView: alertViewSpy, createAccount: createAccountSpy)
		let exp = expectation(description: "Waiting...")
		
		alertViewSpy.observe { viewModel in
			XCTAssertEqual(viewModel, AlertViewModel(title: "Erro", message: "Algo inesperado aconteceu, tente novamenete em alguns instantes"))
			exp.fulfill()
		}
		sut.signUp(viewModel: makeSignUpViewModel())
		createAccountSpy.completeWithError(.unexpected)
		wait(for: [exp], timeout: 1)

	}
	
	func test_signUp_should_show_email_in_use_error_message_if_createAccount_complete_with_email_in_use() throws {
		let alertViewSpy = AlertViewSpy()
		let createAccountSpy = CreateAccountSpy()
		let sut = makeSUT(alertView: alertViewSpy, createAccount: createAccountSpy)
		let exp = expectation(description: "Waiting...")
		
		alertViewSpy.observe { viewModel in
			XCTAssertEqual(viewModel, AlertViewModel(title: "Erro", message: "Esse email já está em uso!"))
			exp.fulfill()
		}
		sut.signUp(viewModel: makeSignUpViewModel())
		createAccountSpy.completeWithError(.emailInUse)
		wait(for: [exp], timeout: 1)
		
	}
	
	func test_signUp_should_show_success_message_if_createAccount_succeeds() throws {
		let alertViewSpy = AlertViewSpy()
		let createAccountSpy = CreateAccountSpy()
		let sut = makeSUT(alertView: alertViewSpy, createAccount: createAccountSpy)
		let exp = expectation(description: "Waiting...")
		
		alertViewSpy.observe { viewModel in
			XCTAssertEqual(viewModel, AlertViewModel(title: "Sucesso", message: "Conta Criada com sucesso."))
			exp.fulfill()
		}
		sut.signUp(viewModel: makeSignUpViewModel())
		createAccountSpy.completeWithAccount(makeAccountModel())
		wait(for: [exp], timeout: 1)
		
	}
	
	func test_signUp_should_show_loading_before_and_after_call_createAccount() throws {
		let loadingViewSpy = LoadingViewSpy()
		let createAccountSpy = CreateAccountSpy()
		let sut = makeSUT(loadingView: loadingViewSpy, createAccount: createAccountSpy)
		let exp = expectation(description: "Waiting...")
		
		loadingViewSpy.observe { viewModel in
			XCTAssertEqual(viewModel, LoadingViewModel(isLoading: true))
			exp.fulfill()
		}
		sut.signUp(viewModel: makeSignUpViewModel())
		wait(for: [exp], timeout: 1)
		
		let exp2 = expectation(description: "Waiting...")
		loadingViewSpy.observe { viewModel in
			XCTAssertEqual(viewModel, LoadingViewModel(isLoading: false))
			exp2.fulfill()
		}
		createAccountSpy.completeWithError(.unexpected)
		wait(for: [exp2], timeout: 1)
	}
	
	func test_signUp_should_call_validation_with_correct_values() throws {
		let validationSpy = ValidationSpy()
		let sut = makeSUT(validation: validationSpy)
		let viewModel =  makeSignUpViewModel()
		sut.signUp(viewModel: viewModel)
		
		XCTAssertTrue(NSDictionary(dictionary: validationSpy.data!).isEqual(to: viewModel.toJSON()!))
	}
	
	func test_signUp_should_show_error_message_if_validation_fails() throws {
		let alertViewSpy = AlertViewSpy()
		let validationSpy = ValidationSpy()
		let sut = makeSUT(alertView: alertViewSpy, validation: validationSpy)
		let exp = expectation(description: "Waiting...")
		
		alertViewSpy.observe { viewModel in
			XCTAssertEqual(viewModel, AlertViewModel(title: "Falha na validação", message: "Erro"))
			exp.fulfill()
		}
		validationSpy.simulateError()
		
		sut.signUp(viewModel: makeSignUpViewModel())
		wait(for: [exp], timeout: 1)
	}
	
	
}
	
extension SignUpPresentersTests {
	func makeSUT(loadingView: LoadingView = LoadingViewSpy(),
				 alertView:AlertViewSpy = AlertViewSpy(),
				 createAccount: CreateAccountSpy = CreateAccountSpy(),
				 validation: ValidationSpy = ValidationSpy(),
				 file: StaticString = #filePath,
				 line: UInt = #line) -> SignUpPresenter {
		
		let sut = SignUpPresenter(loadingView: loadingView,
								  alertView: alertView,
								  createAccount: createAccount,
								  validation: validation)
		
		checkMemoryLeak(for: sut, file: file, line: line)
		
		return sut
	}
}

