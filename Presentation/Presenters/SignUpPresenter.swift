//
//  SignUpPresenter.swift
//  Presentation
//
//  Created by Henrique Batista on 20/05/21.
//

import Foundation
import Domain

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
	var createAccount: CreateAccount
	
	public init(alertView: AlertView, emailValidator: EmailValidator, createAccount: CreateAccount) {
		self.alertView = alertView
		self.emailValidator = emailValidator
		self.createAccount = createAccount
	}
	
	public func signUp(viewModel: SignUpViewModel) {
		if let message = validade(viewModel) {
			self.alertView.showMessage(viewModel: AlertViewModel(title:  "Falha na validação", message: message))
		} else {
			let createAccountModel = CreateAccountModel(name: viewModel.name!, email: viewModel.email!, password: viewModel.password!, passwordConfirmation: viewModel.passwordConfirmation!)
			self.createAccount.create(createAccountModel) { result in
				switch result {
					case .failure: self.alertView.showMessage(viewModel: AlertViewModel(title: "Erro", message: "Algo inesperado aconteceu, tente novamenete em alguns instantes"))
					case .success: break
				}
			}
		}
	}
	
	private func validade(_ viewModel: SignUpViewModel) -> String?{
		if viewModel.name == nil || viewModel.name!.isEmpty {
			return "O campo Nome é obrigatório!"
		} else if viewModel.email == nil || viewModel.email!.isEmpty {
			return "O campo Email é obrigatório!"
		} else if viewModel.password == nil || viewModel.password!.isEmpty {
			return "O campo Senha é obrigatório!"
		} else if viewModel.passwordConfirmation == nil || viewModel.passwordConfirmation!.isEmpty {
			return "O campo Confirmar senha é obrigatório!"
		} else if viewModel.password != viewModel.passwordConfirmation {
			return "Os campos de senha devem ser iguais!"
		} else if !emailValidator.isValid(email: viewModel.email!) {
			return "Email Inválido!"
		}
		
		return nil
	}
}
