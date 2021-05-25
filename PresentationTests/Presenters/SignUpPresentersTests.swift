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
		let alertViewSpy = AlertViewSpy()
		let sut = makeSUT(alertView: alertViewSpy)
		let signUpViewmModel = SignUpViewModel(email: "123@teste.com", password: "secret", passwordConfirmation: "secret")
		
		sut.signUp(viewModel: signUpViewmModel)
		XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falha na validação", message: "O campo nome é obrigatório!"))
	}
	
	func test_signUp_should_show_error_message_if_email_is_not_provided() throws {
		let alertViewSpy = AlertViewSpy()
		let sut = makeSUT(alertView: alertViewSpy)
		let signUpViewmModel = SignUpViewModel(name: "any_name", password: "secret", passwordConfirmation: "secret")
		
		sut.signUp(viewModel: signUpViewmModel)
		XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falha na validação", message: "O campo email é obrigatório!"))
	}
	
	func test_signUp_should_show_error_message_if_password_is_not_provided() throws {
		let alertViewSpy = AlertViewSpy()
		let sut = makeSUT(alertView: alertViewSpy)
		let signUpViewmModel = SignUpViewModel(name: "any_name", email: "123@teste.com", passwordConfirmation: "secret")
		
		sut.signUp(viewModel: signUpViewmModel)
		XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falha na validação", message: "O campo senha é obrigatório!"))
	}
	
	func test_signUp_should_show_error_message_if_confirmation_password_is_not_provided() throws {
		let alertViewSpy = AlertViewSpy()
		let sut = makeSUT(alertView: alertViewSpy)
		let signUpViewmModel = SignUpViewModel(name: "any_name", email: "123@teste.com", password: "secret")
		
		sut.signUp(viewModel: signUpViewmModel)
		XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falha na validação", message: "O campo confirmar senha é obrigatório!"))
	}
	
	func test_signUp_should_show_error_message_if_confirmation_password_dont_match() throws {
		let alertViewSpy = AlertViewSpy()
		let sut = makeSUT(alertView: alertViewSpy)
		let signUpViewmModel = SignUpViewModel(name: "any_name", email: "123@teste.com", password: "secret", passwordConfirmation: "not_secret")
		
		sut.signUp(viewModel: signUpViewmModel)
		XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falha na validação", message: "Os campos de senha devem ser iguais!"))
	}
	
	func test_signUp_should_emailValidator_with_correct_email() throws {
		let emailValidatorSpy = EmailValidatorSpy()
		let sut = makeSUT(emailValidator: emailValidatorSpy)
		let signUpViewmModel = SignUpViewModel(name: "any_name", email: "invalid@teste.com", password: "secret", passwordConfirmation: "secret")
		
		sut.signUp(viewModel: signUpViewmModel)
		XCTAssertEqual(emailValidatorSpy.email, signUpViewmModel.email)
	}
	
	func test_signUp_should_show_error_message_if_invalid_email_is_provided() throws {
		let alertViewSpy = AlertViewSpy()
		let emailValidatorSpy = EmailValidatorSpy()
		let sut = makeSUT(alertView: alertViewSpy, emailValidator: emailValidatorSpy)
		let signUpViewmModel = SignUpViewModel(name: "any_name", email: "invalid@teste.com", password: "secret", passwordConfirmation: "secret")
		emailValidatorSpy.validFlag = false
		sut.signUp(viewModel: signUpViewmModel)
		
		XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falha na validação", message: "Email Inválido!"))
	}
}
	
extension SignUpPresentersTests {
	func makeSUT(alertView:AlertViewSpy = AlertViewSpy(), emailValidator: EmailValidatorSpy = EmailValidatorSpy()) -> SignUpPresenter {		
		return SignUpPresenter(alertView: alertView, emailValidator: emailValidator)
	}
	
	class AlertViewSpy: AlertView {
		var viewModel: AlertViewModel?
		
		func showMessage(viewModel: AlertViewModel) {
			self.viewModel = viewModel
		}
	}
	
	class EmailValidatorSpy: EmailValidator {
		var validFlag = true
		var email: String?
		
		func isValid(email: String) -> Bool{
			self.email = email
			return validFlag
		}
	}
}

