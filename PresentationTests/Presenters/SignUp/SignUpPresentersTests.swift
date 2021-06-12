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
	
	func test_signUp_should_show_error_message_if_name_is_not_provided() throws {
		let alertViewSpy = AlertViewSpy()
		let sut = makeSUT(alertView: alertViewSpy)
		let exp = expectation(description: "Waiting...")
		
		alertViewSpy.observe { viewModel in
			XCTAssertEqual(viewModel, makeAlertViewModel(fieldName: "Nome"))
			exp.fulfill()
		}
		sut.signUp(viewModel: makeSignUpViewModel(name: nil))
		wait(for: [exp], timeout: 1)
	}
	
	func test_signUp_should_show_error_message_if_email_is_not_provided() throws {
		let alertViewSpy = AlertViewSpy()
		let sut = makeSUT(alertView: alertViewSpy)
		let exp = expectation(description: "Waiting...")
		
		alertViewSpy.observe { viewModel in
			XCTAssertEqual(viewModel, makeAlertViewModel(fieldName: "Email"))
			exp.fulfill()
		}
		sut.signUp(viewModel: makeSignUpViewModel(email: nil))
		wait(for: [exp], timeout: 1)
	}
	
	func test_signUp_should_show_error_message_if_password_is_not_provided() throws {
		let alertViewSpy = AlertViewSpy()
		let sut = makeSUT(alertView: alertViewSpy)
		let exp = expectation(description: "Waiting...")
		
		alertViewSpy.observe { viewModel in
			XCTAssertEqual(viewModel, makeAlertViewModel(fieldName: "Senha"))
			exp.fulfill()
		}
		sut.signUp(viewModel: makeSignUpViewModel(password: nil))
		wait(for: [exp], timeout: 1)
	}
	
	func test_signUp_should_show_error_message_if_confirmation_password_is_not_provided() throws {
		let alertViewSpy = AlertViewSpy()
		let sut = makeSUT(alertView: alertViewSpy)
		let exp = expectation(description: "Waiting...")
		
		alertViewSpy.observe { viewModel in
			XCTAssertEqual(viewModel, makeAlertViewModel(fieldName: "Confirmar senha"))
			exp.fulfill()
		}
		sut.signUp(viewModel: makeSignUpViewModel(passwordConfirmation: nil))
		wait(for: [exp], timeout: 1)
	}
	
	func test_signUp_should_show_error_message_if_confirmation_password_dont_match() throws {
		let alertViewSpy = AlertViewSpy()
		let sut = makeSUT(alertView: alertViewSpy)
		let exp = expectation(description: "Waiting...")
		
		alertViewSpy.observe { viewModel in
			XCTAssertEqual(viewModel, AlertViewModel(title: "Falha na validação", message: "Os campos de senha devem ser iguais!"))
			exp.fulfill()
		}
		sut.signUp(viewModel: makeSignUpViewModel(passwordConfirmation: "not_secret"))
		wait(for: [exp], timeout: 1)
	}
	
	func test_signUp_should_show_error_message_if_invalid_email_is_provided() throws {
		let alertViewSpy = AlertViewSpy()
		let emailValidatorSpy = EmailValidatorSpy()
		let sut = makeSUT(alertView: alertViewSpy, emailValidator: emailValidatorSpy)
		emailValidatorSpy.validFlag = false
		let exp = expectation(description: "Waiting...")
		
		alertViewSpy.observe { viewModel in
			XCTAssertEqual(viewModel, AlertViewModel(title: "Falha na validação", message: "Email Inválido!"))
			exp.fulfill()
		}
		sut.signUp(viewModel: makeSignUpViewModel())
		wait(for: [exp], timeout: 1)

	}
	
	func test_signUp_should_emailValidator_with_correct_email() throws {
		let emailValidatorSpy = EmailValidatorSpy()
		let sut = makeSUT(emailValidator: emailValidatorSpy)
		let signUpViewmModel = makeSignUpViewModel(email: "invalid@teste.com")
		
		sut.signUp(viewModel: signUpViewmModel)
		XCTAssertEqual(emailValidatorSpy.email, signUpViewmModel.email)
	}
	
	func test_signUp_should_call_add_account_with_correct_values() throws {
		let createAccountSpy = CreateAccountSpy()
		let sut = makeSUT(createAccount: createAccountSpy)
		sut.signUp(viewModel: makeSignUpViewModel())
		
		XCTAssertEqual(createAccountSpy.createAccountModel, makeCreateAccountModel())
	}
	
	func test_signUp_should_show_error_message_if_createAccount_fails() throws {
		let alertViewSpy = AlertViewSpy()
		let createAccountSpy = CreateAccountSpy()
		let sut = makeSUT(alertView: alertViewSpy, createAccount: createAccountSpy)
		let exp = expectation(description: "Waiting...")
		
		alertViewSpy.observe { viewModel in
			XCTAssertEqual(viewModel, makeErrorAlertViewModel(message: "Algo inesperado aconteceu, tente novamenete em alguns instantes"))
			exp.fulfill()
		}
		sut.signUp(viewModel: makeSignUpViewModel())
		createAccountSpy.completeWithError(.unexpected)
		wait(for: [exp], timeout: 1)

	}
	
	func test_signUp_should_show_success_message_if_createAccount_succeeds() throws {
		let alertViewSpy = AlertViewSpy()
		let createAccountSpy = CreateAccountSpy()
		let sut = makeSUT(alertView: alertViewSpy, createAccount: createAccountSpy)
		let exp = expectation(description: "Waiting...")
		
		alertViewSpy.observe { viewModel in
			XCTAssertEqual(viewModel, makeSuccessAlertViewModel(message: "Conta Criada com sucesso."))
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
	
	
}
	
extension SignUpPresentersTests {
	func makeSUT(loadingView: LoadingView = LoadingViewSpy(),
				 alertView:AlertViewSpy = AlertViewSpy(),
				 emailValidator: EmailValidatorSpy = EmailValidatorSpy(),
				 createAccount: CreateAccountSpy = CreateAccountSpy(),
				 file: StaticString = #filePath,
				 line: UInt = #line) -> SignUpPresenter {
		
		let sut = SignUpPresenter(loadingView: loadingView, alertView: alertView, emailValidator: emailValidator, createAccount: createAccount)
		checkMemoryLeak(for: sut, file: file, line: line)
		
		return sut
	}
}


