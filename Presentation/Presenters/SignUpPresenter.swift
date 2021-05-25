//
//  SignUpPresenter.swift
//  Presentation
//
//  Created by Henrique Batista on 20/05/21.
//

import Foundation

public struct SignUpViewModel {
	public var name: String?
	public var email: String?
	public var password: String?
	public var passwordConfirmation: String?
	
	public init(name: String? = nil, email: String? = nil, password: String? = nil, passwordConfirmation: String? = nil) {
		self.name = name
		self.email = email
		self.password = password
		self.passwordConfirmation = passwordConfirmation

	}
}

public final class SignUpPresenter {
	var alertView: AlertView
	var emailValidator: EmailValidator
	
	public init(alertView: AlertView, emailValidator: EmailValidator) {
		self.alertView = alertView
		self.emailValidator = emailValidator
	}
	
	public func signUp(viewModel: SignUpViewModel) {
		if let message = validade(viewModel) {
			self.alertView.showMessage(viewModel: AlertViewModel(title:  "Falha na validação", message: message))
		}
	}
	
	private func validade(_ viewModel: SignUpViewModel) -> String?{
		if viewModel.name == nil || viewModel.name!.isEmpty {
			return "O campo nome é obrigatório!"
		} else if viewModel.email == nil || viewModel.email!.isEmpty {
			return "O campo email é obrigatório!"
		} else if viewModel.password == nil || viewModel.password!.isEmpty {
			return "O campo senha é obrigatório!"
		} else if viewModel.passwordConfirmation == nil || viewModel.passwordConfirmation!.isEmpty {
			return "O campo confirmar senha é obrigatório!"
		} else if viewModel.password != viewModel.passwordConfirmation {
			return "Os campos de senha devem ser iguais!"
		} else if !emailValidator.isValid(email: viewModel.email!) {
			return "Email Inválido!"
		}
		
		return nil
	}
}
