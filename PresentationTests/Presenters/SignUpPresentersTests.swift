//
//  PresentationTests.swift
//  PresentationTests
//
//  Created by Henrique Batista on 20/05/21.
//

import XCTest
import Presentation

class SignUpPresentersTests: XCTestCase {
	
	func test_signUp_should_show_error_message_if_name_is_not_provided() throws {
		let (sut, alertViewSpy) = makeSUT()
		let signUpViewmModel = SignUpViewModel(email: "123@teste.com", password: "secret", passwordConfirmation: "secret")
		
		sut.signUp(viewModel: signUpViewmModel)
		XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falha na validação", message: "O campo nome é obrigatório!"))
	}
	
	func test_signUp_should_show_error_message_if_email_is_not_provided() throws {
		let (sut, alertViewSpy) = makeSUT()
		let signUpViewmModel = SignUpViewModel(name: "any_name", password: "secret", passwordConfirmation: "secret")
		
		sut.signUp(viewModel: signUpViewmModel)
		XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falha na validação", message: "O campo email é obrigatório!"))
	}
	
	func test_signUp_should_show_error_message_if_password_is_not_provided() throws {
		let (sut, alertViewSpy) = makeSUT()
		let signUpViewmModel = SignUpViewModel(name: "any_name", email: "123@teste.com", passwordConfirmation: "secret")
		
		sut.signUp(viewModel: signUpViewmModel)
		XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falha na validação", message: "O campo senha é obrigatório!"))
	}
	
	func test_signUp_should_show_error_message_if_confirmation_password_is_not_provided() throws {
		let (sut, alertViewSpy) = makeSUT()
		let signUpViewmModel = SignUpViewModel(name: "any_name", email: "123@teste.com", password: "secret")
		
		sut.signUp(viewModel: signUpViewmModel)
		XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falha na validação", message: "O campo confirmar senha é obrigatório!"))
	}
}
	
extension SignUpPresentersTests {
	func makeSUT() -> (sut: SignUpPresenter, alertViewSpy: AlertViewSpy) {
		let alertViewSpy = AlertViewSpy()
		let sut = SignUpPresenter(alertView: alertViewSpy)
		
		return (sut, alertViewSpy)
	}
	
	class AlertViewSpy: AlertView {
		var viewModel: AlertViewModel?
		
		func showMessage(viewModel: AlertViewModel) {
			self.viewModel = viewModel
		}
	}
}


