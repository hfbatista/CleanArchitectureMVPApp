//
//  SignUpPresenter.swift
//  Presentation
//
//  Created by Henrique Batista on 20/05/21.
//

import Foundation
import Domain

public final class SignUpPresenter {
	private let alertView: AlertView
	private let emailValidator: EmailValidator
	private let createAccount: CreateAccount
	private let loadingView: LoadingView
	
	public init(loadingView: LoadingView, alertView: AlertView, emailValidator: EmailValidator, createAccount: CreateAccount) {
		self.alertView = alertView
		self.emailValidator = emailValidator
		self.createAccount = createAccount
		self.loadingView = loadingView
	}
	
	public func signUp(viewModel: SignUpViewModel) {
		if let message = validade(viewModel) {
			self.alertView.showMessage(viewModel: AlertViewModel(title:  "Falha na validação", message: message))
		} else {
			self.loadingView.display(viewModel: LoadingViewModel(isLoading: true))
			self.createAccount.create(SignUpMapper.toCreateAccountModel(viewModel: viewModel)) { [weak self] result in
				DispatchQueue.main.async { [weak self] in
					guard let self = self else { return }
					self.loadingView.display(viewModel: LoadingViewModel(isLoading: false))
					
					switch result {
						case .failure: self.alertView.showMessage(viewModel: AlertViewModel(title: "Erro", message: "Algo inesperado aconteceu, tente novamenete em alguns instantes"))
						case .success: self.alertView.showMessage(viewModel: AlertViewModel(title: "Sucesso", message: "Conta Criada com sucesso."))
					}
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
