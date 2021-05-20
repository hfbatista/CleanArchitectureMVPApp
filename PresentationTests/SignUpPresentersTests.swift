//
//  PresentationTests.swift
//  PresentationTests
//
//  Created by Henrique Batista on 19/05/21.
//

import XCTest

class SignUpPresenter {
	var alertView: AlertView?
	
	init(alertView: AlertView) {
		self.alertView = alertView
	}
	
	func signUp(viewModel: SignUpViewModel) {
		if viewModel.name == nil || viewModel.name!.isEmpty {
			self.alertView?.showMessage(viewModel: AlertViewModel(title:  "Falha na validação", message: "O campo nome é obrigatório!"))
		}
	}
}

protocol AlertView {
	func showMessage(viewModel: AlertViewModel)
}

struct AlertViewModel: Equatable{
	var title: String
	var message: String
}

struct SignUpViewModel {
	var name: String?
	var email: String?
	var password: String?
	var passwordConfirmation: String?
}

class SignUpPresentersTests: XCTestCase {

    func test_signUp_should_show_error_message_if_name_is_not_provided() throws {
		let alertViewSpy = AlertViewSpy()
		let sut = SignUpPresenter(alertView: alertViewSpy)
		let signUpViewmModel = SignUpViewModel(email: "123@teste.com", password: "secret", passwordConfirmation: "secret")
	
		
		sut.signUp(viewModel: signUpViewmModel)
		XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falha na validação", message: "O campo nome é obrigatório!"))
    }
}

extension SignUpPresentersTests {
	class AlertViewSpy: AlertView {
		var viewModel: AlertViewModel?
		
		func showMessage(viewModel: AlertViewModel) {
			self.viewModel = viewModel
		}
	}
}

