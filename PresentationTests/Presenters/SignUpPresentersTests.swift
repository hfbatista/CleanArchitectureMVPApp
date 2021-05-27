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
		
		sut.signUp(viewModel: makeSignUpViewModel(name: nil))
		XCTAssertEqual(alertViewSpy.viewModel, makeAlertViewModel(fieldName: "Nome"))
	}
	
	func test_signUp_should_show_error_message_if_email_is_not_provided() throws {
		let alertViewSpy = AlertViewSpy()
		let sut = makeSUT(alertView: alertViewSpy)
		
		sut.signUp(viewModel: makeSignUpViewModel(email: nil))
		XCTAssertEqual(alertViewSpy.viewModel,  makeAlertViewModel(fieldName: "Email"))
	}
	
	func test_signUp_should_show_error_message_if_password_is_not_provided() throws {
		let alertViewSpy = AlertViewSpy()
		let sut = makeSUT(alertView: alertViewSpy)

		sut.signUp(viewModel:  makeSignUpViewModel(password: nil))
		XCTAssertEqual(alertViewSpy.viewModel,  makeAlertViewModel(fieldName: "Senha"))
	}
	
	func test_signUp_should_show_error_message_if_confirmation_password_is_not_provided() throws {
		let alertViewSpy = AlertViewSpy()
		let sut = makeSUT(alertView: alertViewSpy)

		sut.signUp(viewModel:  makeSignUpViewModel(passwordConfirmation: nil))
		XCTAssertEqual(alertViewSpy.viewModel,  makeAlertViewModel(fieldName: "Confirmar senha"))
	}
	
	func test_signUp_should_show_error_message_if_confirmation_password_dont_match() throws {
		let alertViewSpy = AlertViewSpy()
		let sut = makeSUT(alertView: alertViewSpy)

		sut.signUp(viewModel: makeSignUpViewModel(passwordConfirmation: "not_secret"))
		XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falha na validação", message: "Os campos de senha devem ser iguais!"))
	}
	
	func test_signUp_should_show_error_message_if_invalid_email_is_provided() throws {
		let alertViewSpy = AlertViewSpy()
		let emailValidatorSpy = EmailValidatorSpy()
		let sut = makeSUT(alertView: alertViewSpy, emailValidator: emailValidatorSpy)
		emailValidatorSpy.validFlag = false
		sut.signUp(viewModel: makeSignUpViewModel())
		
		XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falha na validação", message: "Email Inválido!"))
	}
	
	func test_signUp_should_emailValidator_with_correct_email() throws {
		let emailValidatorSpy = EmailValidatorSpy()
		let sut = makeSUT(emailValidator: emailValidatorSpy)
		let signUpViewmModel = makeSignUpViewModel(email: "invalid@teste.com")
		
		sut.signUp(viewModel: signUpViewmModel)
		XCTAssertEqual(emailValidatorSpy.email, signUpViewmModel.email)
	}
}
	
extension SignUpPresentersTests {
	func makeSUT(alertView:AlertViewSpy = AlertViewSpy(), emailValidator: EmailValidatorSpy = EmailValidatorSpy()) -> SignUpPresenter {
		return SignUpPresenter(alertView: alertView, emailValidator: emailValidator)
	}
	
	func makeSignUpViewModel(name: String? = "any_name", email: String? = "123@teste.com", password: String? = "secret", passwordConfirmation: String? = "secret") -> SignUpViewModel {
		return SignUpViewModel(name: name, email: email, password: password, passwordConfirmation: passwordConfirmation)
	}
	
	func makeAlertViewModel(fieldName: String) -> AlertViewModel {
		return AlertViewModel(title: "Falha na validação", message: "O campo \(fieldName) é obrigatório!")
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


